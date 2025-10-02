import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/api/api_services.dart';
import '../../shared/admin_widgets/text_editor_widget.dart';

class AddInsightForm extends StatefulWidget {
  static const String route = '/Admin/AddInsight';
  const AddInsightForm({super.key});

  @override
  State<AddInsightForm> createState() => _AddInsightFormState();
}

class _AddInsightFormState extends State<AddInsightForm> {
  final ApiService _apiService = ApiService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _scheduleDateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final GlobalKey<AdvancedTextEditorState> _editorKey = GlobalKey<AdvancedTextEditorState>();
  PlatformFile? _pickedFile;
  Uint8List? _fileBytes;
  String? _fileName;
  String? _selectedCategory;
  bool _isLoading = false;

  final List<DropdownMenuItem<String>> _categoryItems = [
    const DropdownMenuItem(value: 'Articles', child: Text('Articles')),
    const DropdownMenuItem(value: 'Events', child: Text('Events')),
    const DropdownMenuItem(value: 'Announcements', child: Text('Announcements')),
    const DropdownMenuItem(value: 'News', child: Text('News')),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _remarksController.dispose();
    _eventDateController.dispose();
    _scheduleDateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
  void _clearScheduleDate() {
    setState(() {
      _scheduleDateController.clear();
      _timeController.clear();
    });
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1996),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            bannerTheme: const MaterialBannerThemeData(
              backgroundColor: Color(0xFF630606),
              contentTextStyle: TextStyle(color: Colors.white),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              headerBackgroundColor: const Color(0xFF630606),
              headerForegroundColor: Colors.white,
              dayForegroundColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                } else if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return Colors.black;
              }),
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF630606),
              onPrimary: Colors.white,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              buttonColor: Color(0xFF630606),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  // Time Picker: formats output as HH:MM
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        // Format the time as HH:MM
        final String formattedTime =
            '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
        _timeController.text = formattedTime;
      });
    }
  }

  void _showTopSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : const Color(0xFF630606),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          left: 550,
          right: 550,
        ),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<void> _submitForm(bool publishNow) async {
    // Validate required fields (Title, Category, Event Date)
    if (_titleController.text.isEmpty ||
        _selectedCategory == null ||
        _eventDateController.text.isEmpty) {
      _showTopSnackBar('Please fill all required fields', isError: true);
      return;
    }

    // Check if an image is selected
    if (_pickedFile == null || _fileBytes == null) {
      _showTopSnackBar('An image file is required for the insight.', isError: true);
      return;
    }

    // --- SCHEDULED PUBLISH VALIDATION (if not publishing now) ---
    if (!publishNow) {
      final scheduleDate = _scheduleDateController.text;
      final scheduleTime = _timeController.text;

      if (scheduleDate.isEmpty || scheduleTime.isEmpty) {
        _showTopSnackBar('Both Schedule Date and Time must be set to publish on schedule.', isError: true);
        return;
      }

      // Regular Expression to match HH:MM format (e.g., 00:00 to 23:59)
      // Requires two digits, a colon, and two more digits. This fails '1200'.
      final RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');

      if (!timeRegex.hasMatch(scheduleTime)) {
        // THIS CATCHES invalid formats like '1200'
        _showTopSnackBar('Invalid Time Format. Please use HH:MM (e.g., 12:00).', isError: true);
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      final response = await _apiService.createInsight(
        title: _titleController.text,
        content: _editorKey.currentState?.getHtmlContent() ?? '',
        category: _selectedCategory!,
        eventDate: _eventDateController.text,
        remarks: _remarksController.text.isEmpty ? null : _remarksController.text,
        publishNow: publishNow,
        scheduledAt: publishNow ? null : '${_scheduleDateController.text} ${_timeController.text}',
        fileBytes: _pickedFile != null ? _fileBytes : null,
        fileName: _fileName,
      );

      _showTopSnackBar(response['data']['message']);
      _clearForm();
    } catch (e) {
      _showTopSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _clearForm() {
    setState(() {
      _titleController.clear();
      _remarksController.clear();
      _eventDateController.clear();
      _scheduleDateController.clear();
      _timeController.clear();
      _selectedCategory = null;
      _pickedFile = null;
      _fileBytes = null;
      _fileName = null;
      _editorKey.currentState?.clearContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if both schedule date AND time are set to enable the schedule button
    final bool canSchedule = _scheduleDateController.text.isNotEmpty && _timeController.text.isNotEmpty;
    // Check if either schedule date OR time is set to show the close icon
    final bool hasScheduledFields = _scheduleDateController.text.isNotEmpty || _timeController.text.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("DETAILS", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("DATE OF EVENT", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text("Select the calendar date when the event will take place."),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => _selectDate(context, _eventDateController),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _eventDateController,
                              decoration: const InputDecoration(
                                hintText: "Select Date",
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("CATEGORY", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text("Select the appropriate category that best describes your event."),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          hint: const Text("Select Category"),
                          decoration: const InputDecoration(border: OutlineInputBorder()),
                          items: _categoryItems,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowMultiple: false,
                        );

                        if (result != null && result.files.isNotEmpty) {
                          setState(() {
                            _pickedFile = result.files.first;
                            _fileName = _pickedFile!.name;
                            _fileBytes = _pickedFile!.bytes;
                          });
                        }
                      },
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: _fileBytes != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            _fileBytes!,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                            : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_file, size: 32, color: Colors.grey),
                              SizedBox(height: 8),
                              Text("Upload File", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_fileBytes != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _fileName ?? 'Selected file',
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _pickedFile = null;
                            _fileBytes = null;
                            _fileName = null;
                          });
                        },
                        child: const Text('Remove'),
                      ),
                    ],
                    const SizedBox(height: 24),
                    const Text("SET AS MAIN ARTICLE", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text(
                      "Mark this content as the primary or featured article to highlight it on the homepage or top of the list.",
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _remarksController.text.isNotEmpty ? _remarksController.text : 'Sub', // Use controller value
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Main',
                          child: Text('Main'),
                        ),
                        DropdownMenuItem(
                          value: 'Sub',
                          child: Text('Sub'),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          _remarksController.text = newValue;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          AdvancedTextEditor(key: _editorKey),
          const SizedBox(height: 20),
          const Text("PUBLISHING ARTICLE", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Schedule", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Select a date to make your article public."),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, _scheduleDateController),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _scheduleDateController,
                            decoration: const InputDecoration(
                              hintText: "Select Date",
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            onChanged: (_) => setState(() {}), // Trigger rebuild to update button state
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectTime(context),
                        child: TextFormField(
                          controller: _timeController,
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            hintText: "Input Time (e.g., 12:00)",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          // Manual input allowed, validation done in _submitForm
                          onChanged: (_) => setState(() {}), // Trigger rebuild to update button state
                        ),
                      ),
                    ),
                    if (hasScheduledFields) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: _clearScheduleDate,
                        tooltip: 'Remove schedule date',
                      ),
                    ],
                    const SizedBox(width: 12),
                    ElevatedButton(
                      // Button enabled only when BOTH date and time are set (canSchedule)
                      onPressed: canSchedule
                          ? () => _submitForm(false)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: canSchedule
                            ? const Color(0xFF630606)
                            : Colors.grey,
                      ),
                      child: const Text(
                        "Publish Schedule",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text("Article will be private before publishing.",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 20),
                const Text("Publish Now", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Make your event or content live immediately so it's visible to the public right away."),
                const SizedBox(height: 12),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // Publish Now is disabled if a schedule is actively being set
                      backgroundColor: !hasScheduledFields
                          ? const Color(0xFF630606)
                          : Colors.grey,
                    ),
                    onPressed: !hasScheduledFields
                        ? () => _submitForm(true)
                        : null,
                    child:  _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "Publish now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}