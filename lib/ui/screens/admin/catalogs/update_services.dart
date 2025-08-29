import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateServiceForm extends StatefulWidget {
  final int serviceId;
  final Map<String, dynamic> initialData;
  final VoidCallback onUpdateSuccess;

  const UpdateServiceForm({
    super.key,
    required this.serviceId,
    required this.initialData,
    required this.onUpdateSuccess,
  });

  @override
  State<UpdateServiceForm> createState() => _UpdateServiceFormState();
}

class _UpdateServiceFormState extends State<UpdateServiceForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _updatedByController = TextEditingController();

  PlatformFile? _pickedFile;
  Uint8List? _fileBytes;
  String? _fileName;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize form with existing data
    _nameController.text = widget.initialData['name'] ?? '';
    _descriptionController.text = widget.initialData['description'] ?? '';
    _updatedByController.text = 'admin'; // Set default or get from user session
  }

  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> _updateService() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter service name')),
      );
      return;
    }

    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter service description')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final token = await _getAuthToken();
      if (token == null) throw Exception('Authentication token not found');

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            'https://dev-api-janus.fortress-asya.com:18043/api/private/v1/catalogs/services/${widget
                .serviceId}'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      // Add form data
      request.fields['name'] = _nameController.text;
      request.fields['description'] = _descriptionController.text;
      request.fields['updated_by'] = _updatedByController.text;

      // Add file if selected
      if (_fileBytes != null && _fileName != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image_path',
          _fileBytes!,
          filename: _fileName,
        ));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 204) {
        widget.onUpdateSuccess();
      } else {
        throw Exception('Failed to update service: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating service: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDE (Form Fields)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SERVICE NAME
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("SERVICE NAME",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Service Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // DESCRIPTION
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("DESCRIPTION",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      minLines: 3,
                      maxLines: 5,
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // UPDATE BUTTON
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF630606),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _isLoading ? null : _updateService,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "Update Service",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          // RIGHT SIDE (Image Upload)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
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
                    height: 200,
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
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                        const Center(
                          child: Icon(
                              Icons.broken_image, size: 32, color: Colors.grey),
                        ),
                      ),
                    )
                        : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file, size: 32, color: Colors.grey),
                          SizedBox(height: 8),
                          Text("Upload New Image",
                              style: TextStyle(color: Colors.grey)),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
