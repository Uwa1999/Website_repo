import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateCatalogForm extends StatefulWidget {
  final int catalogId;
  final Map<String, dynamic> initialData;
  final VoidCallback onUpdateSuccess;

  const UpdateCatalogForm({
    super.key,
    required this.catalogId,
    required this.initialData,
    required this.onUpdateSuccess,
  });

  @override
  State<UpdateCatalogForm> createState() => _UpdateCatalogFormState();
}

class _UpdateCatalogFormState extends State<UpdateCatalogForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _updatedByController = TextEditingController();

  PlatformFile? _pickedFile;
  Uint8List? _fileBytes;
  String? _fileName;
  bool _isEnabled = true;
  bool _isLoading = false;
  bool _isFetchingStatus = true; // Add loading state for status fetch

  @override
  void initState() {
    super.initState();
    // Initialize form with existing data
    _nameController.text = widget.initialData['name'] ?? '';
    _descriptionController.text = widget.initialData['description'] ?? '';
    _isEnabled = _parseEnabledStatus(widget.initialData['is_enabled']);
    _updatedByController.text = 'admin'; // Set default or get from user session

    // Fetch the latest status from the API
    _fetchCatalogStatus();
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

  // Fetch the latest catalog status from the API
  Future<void> _fetchCatalogStatus() async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/catalogs?page=1'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final catalogs = jsonData['data']['data'] as List<dynamic>;

        // Find the specific catalog by ID
        final catalog = catalogs.firstWhere(
              (catalog) => catalog['id'] == widget.catalogId,
          orElse: () => null,
        );

        if (catalog != null) {
          setState(() {
            _isEnabled = _parseEnabledStatus(catalog['is_enabled']);
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

  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> _updateCatalog() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter catalog name')),
      );
      return;
    }

    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter catalog description')),
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
            'https://dev-api-janus.fortress-asya.com:18043/api/private/v1/catalogs/${widget
                .catalogId}'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      // Add form data
      request.fields['name'] = _nameController.text;
      request.fields['description'] = _descriptionController.text;
      request.fields['is_enabled'] = _isEnabled.toString();
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
        throw Exception('Failed to update catalog: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating catalog: $e')),
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
          // LEFT SIDE (Form fields + button)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CATALOG NAME
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("CATALOG NAME",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Catalog Name',
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
                const SizedBox(height: 24),

                // ENABLED STATUS
                Row(
                  children: [
                    const Text("ENABLED",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                const SizedBox(height: 32),

                // UPDATE BUTTON
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF630606),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _isLoading ? null : _updateCatalog,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "Update Catalog",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          // RIGHT SIDE (Image upload)
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("CATALOG IMAGE",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
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
                        fit: BoxFit.cover,
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