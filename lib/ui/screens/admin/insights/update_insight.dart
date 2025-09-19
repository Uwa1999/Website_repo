import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/admin_widgets/text_editor_widget.dart';

class UpdateInsightForm extends StatefulWidget {
  static const String route = '/Admin/UpdateInsight';
  final int insightId;
  final Map<String, dynamic> initialData;
  final VoidCallback onUpdateSuccess;

  const UpdateInsightForm({
    super.key,
    required this.insightId,
    required this.initialData,
    required this.onUpdateSuccess,
  });

  @override
  State<UpdateInsightForm> createState() => _UpdateInsightFormState();
}

class _UpdateInsightFormState extends State<UpdateInsightForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _remarksController;
  late final TextEditingController _eventDateController;
  late final TextEditingController _scheduleDateController;
  late final TextEditingController _timeController;

  final GlobalKey<AdvancedTextEditorState> _editorKey = GlobalKey<AdvancedTextEditorState>();
  PlatformFile? _pickedFile;
  Uint8List? _fileBytes;
  String? _fileName;
  String? _selectedCategory;
  bool _isLoading = false;
  bool _isEnabled = true;
  bool _isFetchingStatus = true; // Add loading state for status fetch

  final List<DropdownMenuItem<String>> _categoryItems = [
    const DropdownMenuItem(value: 'Articles', child: Text('Articles')),
    const DropdownMenuItem(value: 'Events', child: Text('Events')),
    const DropdownMenuItem(value: 'News', child: Text('News')),
    const DropdownMenuItem(value: 'Announcements', child: Text('Announcements')),
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialData['title']);
    _remarksController = TextEditingController(text: widget.initialData['remarks'] ?? 'Main');
    _eventDateController = TextEditingController();
    _scheduleDateController = TextEditingController(text: widget.initialData['schedule_date'] ?? '');
    _timeController = TextEditingController(text: widget.initialData['time'] ?? '');
    _selectedCategory = widget.initialData['category'];

    // Initialize with the value from initialData but also fetch the latest status
    _isEnabled = _parseEnabledStatus(widget.initialData['is_enabled']);

    // Fetch the latest status from the API
    _fetchArticleStatus();

    // Initialize editor content after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_editorKey.currentState != null && widget.initialData['content'] != null) {
        _editorKey.currentState!.setHtmlContent(widget.initialData['content']);
      }
    });
  }

  // Helper method to parse enabled status from various data types
  bool _parseEnabledStatus(dynamic enabledValue) {
    if (enabledValue is bool) {
      return enabledValue;
    } else if (enabledValue is String) {
      return enabledValue.toLowerCase() == 'true';
    } else if (enabledValue is int) {
      return enabledValue == 1;
    } else {
      return true; // Default value
    }
  }

  // Fetch the latest article status from the API
  Future<void> _fetchArticleStatus() async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/private/v1/insights/index?page=1'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final articles = jsonData['data']['data'] as List<dynamic>;

        // Find the specific article by ID
        final article = articles.firstWhere(
              (article) => article['id'] == widget.insightId,
          orElse: () => null,
        );

        if (article != null) {
          setState(() {
            _isEnabled = _parseEnabledStatus(article['is_enabled']);
            _isFetchingStatus = false;
          });
        } else {
          setState(() {
            _isFetchingStatus = false;
          });
        }
      } else {
        setState(() {
          _isFetchingStatus = false;
        });
      }
    } catch (e) {
      setState(() {
        _isFetchingStatus = false;
      });
      // Don't show error for status fetch as we already have the initial data
    }
  }

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

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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

  Future<void> _updateInsight() async {
    if (_titleController.text.isEmpty ||
        _selectedCategory == null ||
        _eventDateController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Missing Fields'),
          content: Text('Please fill all required fields'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final token = await _getAuthToken();
      if (token == null) {
        throw Exception('Authentication token not found. Please login again.');
      }

      // Get content from editor or fall back to initial content
      final htmlContent = _editorKey.currentState?.getHtmlContent() ??
          widget.initialData['content'] ??
          '';

      final uri = Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/private/v1/insights/${widget.insightId}');
      final request = http.MultipartRequest('PUT', uri)
        ..headers['Accept'] = 'application/json'
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['title'] = _titleController.text
        ..fields['content'] = htmlContent
        ..fields['remarks'] = _remarksController.text
        ..fields['category'] = _selectedCategory!
        ..fields['event_date'] = _eventDateController.text
        ..fields['updated_by'] = 'admin123'
        ..fields['is_published'] = 'true'
        ..fields['is_enabled'] = _isEnabled.toString(); // Use the enabled state

      if (_pickedFile != null && _fileBytes != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image_path',
          _fileBytes!,
          filename: _fileName ?? 'upload.jpg',
        ));
      } else if (widget.initialData['image_path'] != null) {
        // Include existing image path if no new file was selected
        request.fields['image_path'] = widget.initialData['image_path'];
      }

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200 || response.statusCode == 204) {
        widget.onUpdateSuccess();
      } else if (response.statusCode == 401) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Session Expired'),
            content: const Text('Your session has expired. Please login again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Error'),
            content: Text('Status: ${response.statusCode}\n${responseBody.body}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text('Exception: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(height: 24),
                    // Add ENABLED switch similar to the catalog form
                    Row(
                      children: [
                        const Text("ENABLED", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        _isFetchingStatus
                            ? const CircularProgressIndicator()
                            : Switch(
                          value: _isEnabled,
                          onChanged: (value) {
                            setState(() {
                              _isEnabled = value;
                            });
                          },
                          activeColor: const Color(0xFF630606),
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
                            : widget.initialData['image_path'] != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.initialData['image_path'],
                            fit: BoxFit.fitHeight,
                            errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 48),
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
                      value: _remarksController.text,
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
                          setState(() {
                            _remarksController.text = newValue;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AdvancedTextEditor(
            key: _editorKey,
            initialContent: widget.initialData['content'] ?? '',
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF630606),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _isLoading ? null : _updateInsight,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                "Update Insight",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}