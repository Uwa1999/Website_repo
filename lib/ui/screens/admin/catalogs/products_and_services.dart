import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../services/api/api_services.dart';


class ProductsAndServices extends StatefulWidget {
  static const String route = '/Admin/ProductsAndServices';
  const ProductsAndServices({super.key});

  @override
  State<ProductsAndServices> createState() => _ProductsAndServicesState();
}

class _ProductsAndServicesState extends State<ProductsAndServices> {
  final ApiService _apiService = ApiService();

  // Controllers and state variables remain the same
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescController = TextEditingController();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _serviceDescController = TextEditingController();

  int? _selectedCatalogId;
  List<Map<String, dynamic>> _catalogs = [];

  PlatformFile? _pickedProductFile;
  Uint8List? _productFileBytes;
  String? _productFileName;

  PlatformFile? _pickedServiceFile;
  Uint8List? _serviceFileBytes;
  String? _serviceFileName;

  bool _isLoadingCatalog = false;
  bool _isLoadingService = false;
  bool _isLoadingCatalogs = false;

  @override
  void initState() {
    super.initState();
    _fetchCatalogs();
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

  Future<void> _fetchCatalogs() async {
    // setState(() => _isLoadingCatalogs = true);
    try {
      final catalogs = await _apiService.fetchCatalogs();
      setState(() => _catalogs = catalogs);
    } catch (e) {
      _showTopSnackBar(e.toString(), isError: true);
    } finally {
      // setState(() => _isLoadingCatalogs = false);
    }
  }

  Future<void> _createCatalog() async {
    // Validate all fields
    if (_productNameController.text.isEmpty) {
      _showTopSnackBar('Please enter product name', isError: true);
      return;
    }

    if (_productDescController.text.isEmpty) {
      _showTopSnackBar('Please enter product description', isError: true);
      return;
    }

    if (_productFileBytes == null) {
      _showTopSnackBar('Please upload a product image', isError: true);
      return;
    }

    setState(() => _isLoadingCatalog = true);

    try {
      final response = await _apiService.createCatalog(
        name: _productNameController.text,
        description: _productDescController.text,
        fileBytes: _productFileBytes!,
        fileName: _productFileName,
      );

      _showTopSnackBar(response['data']['message']);
      _clearProductForm();
      _fetchCatalogs();
    } catch (e) {
      _showTopSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoadingCatalog = false);
      }
    }
  }

  Future<void> _createService() async {
    // Validate all fields
    if (_serviceNameController.text.isEmpty) {
      _showTopSnackBar('Please enter service name', isError: true);
      return;
    }

    if (_serviceDescController.text.isEmpty) {
      _showTopSnackBar('Please enter service description', isError: true);
      return;
    }

    if (_selectedCatalogId == null) {
      _showTopSnackBar('Please select a catalog', isError: true);
      return;
    }

    if (_serviceFileBytes == null) {
      _showTopSnackBar('Please upload a service image', isError: true);
      return;
    }

    setState(() => _isLoadingService = true);

    try {
      final response = await _apiService.createService(
        catalogId: _selectedCatalogId!,
        name: _serviceNameController.text,
        description: _serviceDescController.text,
        fileBytes: _serviceFileBytes!,
        fileName: _serviceFileName,
      );

      _showTopSnackBar(response['data']['message']);
      _clearServiceForm();
      setState(() => _selectedCatalogId = null);
    } catch (e) {
      _showTopSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoadingService = false);
      }
    }
  }

  void _clearServiceForm() {
    setState(() {
      _serviceNameController.clear();
      _serviceDescController.clear();
      _pickedServiceFile = null;
      _serviceFileBytes = null;
      _serviceFileName = null;
      _selectedCatalogId = null;
    });
  }

  void _clearProductForm() {
    setState(() {
      _productNameController.clear();
      _productDescController.clear();
      _pickedProductFile = null;
      _productFileBytes = null;
      _productFileName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PRODUCT SECTION
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
                        const Text("PRODUCT", style: TextStyle(fontWeight: FontWeight.bold)),
                        const Text("Input the name of the catalog you want to create"),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _productNameController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("DESCRIPTION", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _productDescController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          minLines: 1,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: 160,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF630606),
                            ),
                            onPressed: _isLoadingCatalog ? null : _createCatalog,
                            child: _isLoadingCatalog
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                              "Create catalog",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
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
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowMultiple: false,
                        );

                        if (result != null && result.files.isNotEmpty) {
                          setState(() {
                            _pickedProductFile = result.files.first;
                            _productFileName = _pickedProductFile!.name;
                            _productFileBytes = _pickedProductFile!.bytes;
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
                        child: _productFileBytes != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            _productFileBytes!,
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
                    if (_productFileBytes != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _productFileName ?? 'Selected file',
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _pickedProductFile = null;
                            _productFileBytes = null;
                            _productFileName = null;
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
          const SizedBox(height: 40),
          const Divider(),
          const SizedBox(height: 40),

          // SERVICE SECTION
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
                        const Text("SERVICES", style: TextStyle(fontWeight: FontWeight.bold)),
                        const Text("Input the name of the services you want to create"),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _serviceNameController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _isLoadingCatalogs
                        ? const CircularProgressIndicator()
                        : DropdownButtonFormField<int>(
                      value: _selectedCatalogId,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Select Catalog'),
                      ),
                      items: _catalogs.map((catalog) {
                        return DropdownMenuItem<int>(
                          value: catalog['id'],
                          child: Text(catalog['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCatalogId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("DESCRIPTION", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _serviceDescController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          minLines: 1,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: 160,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF630606),
                            ),
                            onPressed: _isLoadingService ? null : _createService,
                            child: _isLoadingService
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                              "Create service",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
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
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowMultiple: false,
                        );

                        if (result != null && result.files.isNotEmpty) {
                          setState(() {
                            _pickedServiceFile = result.files.first;
                            _serviceFileName = _pickedServiceFile!.name;
                            _serviceFileBytes = _pickedServiceFile!.bytes;
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
                        child: _serviceFileBytes != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            _serviceFileBytes!,
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
                    if (_serviceFileBytes != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _serviceFileName ?? 'Selected file',
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _pickedServiceFile = null;
                            _serviceFileBytes = null;
                            _serviceFileName = null;
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
        ],
      ),
    );
  }
}