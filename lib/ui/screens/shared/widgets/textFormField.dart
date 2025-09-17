import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../../../core/provider/user_provider.dart';
import 'checkBoxDialog.dart';

class EncodingFields extends StatefulWidget {
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? hintText;
  final String? title;
  final bool readonly;
  final bool dropdown;
  final bool checkbox;
  final bool manualInput;
  final bool searchButton;
  final bool datepicker;
  final bool dateTimePicker;
  final bool obscure;
  final int? maxlength;
  final Function(String)? onChanged;
  final VoidCallback? onSearch;
  final TextInputType? keyboardType;
  final String? errorText;
  final FocusNode? focusNode;
  final Future<List<String>> Function()? fetchDropdownItems;
  final String? dropdownParam;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool showError;

  const EncodingFields({
    Key? key,
    required this.controller,
    this.suffixIcon,
    this.hintText,
    this.title,
    this.readonly = false,
    this.dropdown = false,
    this.checkbox = false,
    this.manualInput = false,
    this.searchButton = false,
    this.datepicker = false,
    this.dateTimePicker = false,
    this.onSearch,
    this.obscure = false,
    this.maxlength,
    this.onChanged,
    this.keyboardType,
    this.errorText,
    this.focusNode,
    this.fetchDropdownItems,
    this.dropdownParam,
    this.validator,
    this.showError = false,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<EncodingFields> createState() => _EncodingFieldsState();
}

class _EncodingFieldsState extends State<EncodingFields> {


  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final errorText = widget.showError ? widget.validator?.call(widget.controller.text) : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: 128,
                child: Text(
                  widget.title!,
                  style: const TextStyle(fontSize: 13, fontFamily: 'Robotothin', fontWeight: FontWeight.w500),
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: widget.manualInput ? null : 35,
                  child: TextFormField(
                    controller: widget.controller,
                    obscureText: widget.obscure && _isObscured,
                    readOnly: widget.readonly,
                    validator: null,
                    maxLines: widget.manualInput ? null : 1,
                    autovalidateMode: AutovalidateMode.disabled,
                    inputFormatters: widget.inputFormatters,
                    onFieldSubmitted: (value) {
                      widget.onSearch?.call();
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(
                        // fontFamily: 'RobotoThin',
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: errorText == null ? const Color(0xFF4B0C0C) : Colors.red,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: errorText == null ? const Color(0xFF4B0C0C) : Colors.red,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: errorText == null ? const Color(0xFF4B0C0C) : Colors.red,
                          width: 0.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      errorText: null, // manual error shown below
                      suffixIcon: _buildSuffixIcon(),
                    ),
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
                if (errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 2),
                    child: Text(
                      errorText,
                      style: const TextStyle(color: Colors.red, fontSize: 10),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _showError = false;
  bool _isObscured = true;
  List<String> _dropdownItems = [];
  bool _isLoading = true;
  List<String> _selectedItems = [];

  final GlobalKey _textFieldKey = GlobalKey();

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        widget.controller.text = formattedDate;
      });
    }
  }

  String _monthString(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  Future<void> _pickDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        final now = DateTime.now();
        final int second = now.second;

        final formattedDateTime = "${date.day.toString().padLeft(2, '0')}-"
            "${_monthString(date.month)}-${date.year} "
            "${time.hour.toString().padLeft(2, '0')}:"
            "${time.minute.toString().padLeft(2, '0')}:"
            "${second.toString().padLeft(2, '0')}";

        setState(() {
          widget.controller.text = formattedDateTime;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.dropdown && widget.dropdownParam != null) {
      _loadDropdownItems();
    }
    widget.controller.addListener(_onTextChanged);
  }

  Future<void> _loadDropdownItems() async {
    try {
      final url = Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/dropdown/index');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['retCode'] == '200') {
          final Map<String, dynamic> dropdowns = responseData['data'];

          if (dropdowns.containsKey(widget.dropdownParam)) {
            if (mounted) {
              setState(() {
                _dropdownItems = List<String>.from(dropdowns[widget.dropdownParam] ?? []);
                _isLoading = false;
              });
            }
          } else {
            print('Dropdown parameter not found: ${widget.dropdownParam}');
            setState(() {
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _isLoading = false;
          });
          print('Failed to fetch dropdown data: ${responseData['message']}');
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print('Failed to load data from API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching dropdown items: $e");
    }
  }

  Widget? _buildSuffixIcon() {
    if (widget.dropdown) {
      if (widget.checkbox) {
        return IconButton(
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  tittle: 'Select Items',
                  icon: Icons.check_box,
                  isLoading: _isLoading,
                  items: _dropdownItems,
                  selectedItems: List.from(_selectedItems),
                  buttonText: 'Close',
                  onChanged: (updatedItems) {
                    setState(() {
                      _selectedItems = updatedItems;
                      widget.controller.text = _selectedItems.join(', ');
                    });
                  },
                );
              },
            );
          },
        );
      } else {
        return SizedBox(
          height: 48,
          width: 40,
          child: Center(
            child: PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              offset: const Offset(0, 40),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              onSelected: (value) {
                setState(() {
                  widget.controller.text = value;
                  print('Selected Status: $value');
                });
              },
              itemBuilder: (context) {
                if (_isLoading) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'loading',
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                  ];
                }
                return _dropdownItems.map((item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item, style: const TextStyle(
                      // fontFamily: 'Robotothin',
                        fontSize: 12
                    )),
                  );
                }).toList();
              },
            ),
          ),
        );
      }
    } else if (widget.searchButton) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: GestureDetector(
          onTap: widget.onSearch,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
              color: Color(0xff15951a),
              borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    // fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (widget.manualInput) {
      return IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.grey,
          size: 15,
        ),
        onPressed: () {
          setState(() {
            widget.controller.clear();
          });
        },
      );
    } else if (widget.obscure) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: Colors.black,
        ),
        onPressed: _toggleVisibility,
      );
    } else if (widget.datepicker) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
        child: IconButton(
          icon: const Icon(Icons.calendar_today, color: Colors.black, size: 20),
          onPressed: _pickDate,
        ),
      );
    } else if (widget.dateTimePicker) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: IconButton(
          icon: const Icon(Icons.event, color: Colors.black, size: 20),
          onPressed: _pickDateTime,
        ),
      );
    } else if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    return null;
  }
}

