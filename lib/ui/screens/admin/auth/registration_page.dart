import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../shared/admin_widgets/text_form_field_widget.dart';
import '../../shared/utils/responsive.dart';
import '../../shared/values/colors.dart';
import 'login_page.dart';

class RegistrationForm extends StatefulWidget {
  static const String route = '/Admin/Registration';
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime? _selectedDate;
  bool _termsAccepted = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _userNameFocusNode = FocusNode();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: Colors.white,
              headerBackgroundColor: Color(0xFF630606),
              headerForegroundColor: Colors.white,
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF630606),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_termsAccepted) {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Processing registration..."),
              ],
            ),
          ),
        );

        final body = {
          "email": _emailController.text.trim(),
          "mobile": _phoneController.text.trim(),
          "username": _userNameController.text.trim(),
          "password": _passwordController.text,
          "firstname": _firstNameController.text.trim(),
          "middlename": _middleNameController.text.trim(),
          "lastname": _lastNameController.text.trim(),
          "birthday": _selectedDate?.toUtc().toIso8601String() ?? "1990-01-01T00:00:00Z"
        };

        try {
          final response = await http.post(
            Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/auth/signup'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(body),
          );

          // Hide loading indicator
          Navigator.of(context).pop();

          final responseData = jsonDecode(response.body);
          if (response.statusCode == 201) {
            _showTopSnackBar('✅ ${responseData['message']}');
            _clearAllFields();

            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacementNamed(context, LoginScreen.route);

            });
          } else {
            final errorDetails = responseData['errors'] ?? responseData['message'] ?? 'Unknown error';

            // Handle specific error cases
            if (responseData['message']?.contains('duplicate key value violates unique constraint') ?? false) {
              if (responseData['message']?.contains('admin_users_email_key') ?? false) {
                _showTopSnackBar('❌ This email address is already registered', isError: true);
                FocusScope.of(context).requestFocus(FocusNode());
                await Future.delayed(const Duration(milliseconds: 300));
                FocusScope.of(context).requestFocus(_emailFocusNode);
              } else if (responseData['message']?.contains('admin_users_email_key') ?? false) {
                _showTopSnackBar('❌ This email address is already registered', isError: true);
                _emailController.clear();
                FocusScope.of(context).requestFocus(FocusNode());
                await Future.delayed(const Duration(milliseconds: 300));
                FocusScope.of(context).requestFocus(_emailFocusNode);
              } else if (responseData['message']?.contains('admin_users_mobile_key') ?? false) {
                _showTopSnackBar('❌ This phone number is already registered', isError: true);
                FocusScope.of(context).requestFocus(FocusNode());
                await Future.delayed(const Duration(milliseconds: 300));
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              } else {
                _showTopSnackBar('❌ Registration failed: ${responseData['message']}', isError: true);
              }
            } else if (responseData['errors'] != null) {
              // Handle other validation errors from the server
              final errors = responseData['errors'] as Map<String, dynamic>;
              if (errors.containsKey('email')) {
                _showTopSnackBar('❌ Email error: ${errors['email'][0]}', isError: true);
                FocusScope.of(context).requestFocus(_emailFocusNode);
              } else if (errors.containsKey('mobile')) {
                _showTopSnackBar('❌ Phone error: ${errors['mobile'][0]}', isError: true);
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              } else if (errors.containsKey('username')) {
                _showTopSnackBar('❌ Username error: ${errors['username'][0]}', isError: true);
                FocusScope.of(context).requestFocus(_userNameFocusNode);
              } else {
                _showTopSnackBar('❌ Registration failed: Please check your details', isError: true);
              }
            } else {
              _showTopSnackBar('❌ Registration failed: ${responseData['message'] ?? 'Unknown error'}', isError: true);
            }
          }
        } catch (e) {
          Navigator.of(context).pop();
          _showTopSnackBar('❌ Error: ${e.toString()}', isError: true);
        }
      } else {
        _showTopSnackBar('Please accept the terms and conditions', isError: true);
      }
    } else {
      _showTopSnackBar('Please fill all required fields correctly', isError: true);
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

  void _clearAllFields() {
    _firstNameController.clear();
    _middleNameController.clear();
    _lastNameController.clear();
    _userNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _phoneController.clear();
    _formKey.currentState?.reset();
    setState(() {
      _termsAccepted = false;
      _selectedDate = null;
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _userNameFocusNode.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background container - matches login page
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white],
                ),
              ),
            ),
          ),

          // Logo at top-left - matches login page
          Positioned(
            top: 20,
            left: 20,
            child: SizedBox(
              width: Responsive.isDesktop(context) ? 200 : size.width * 0.5,
              height: Responsive.isDesktop(context) ? 90 : size.width * 0.2,
              child: ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/images/fdsap.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main form content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Responsive(
                desktop: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 800,
                    minHeight: size.height * 0.7,
                  ),
                  child: _buildFormContent(),
                ),
                mobile: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                    minHeight: size.height * 0.7,
                  ),
                  child: _buildFormContent(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Registration",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Responsive layout
              Responsive(
                desktop: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildNameFields()),
                    const SizedBox(width: 16),
                    Expanded(child: _buildContactFields()),
                  ],
                ),
                mobile: Column(
                  children: [
                    _buildNameFields(),
                    const SizedBox(height: 16),
                    _buildContactFields(),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Terms checkbox
              Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _termsAccepted = value!;
                      });
                    },
                    activeColor: const Color(0xFF630606),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _termsAccepted = !_termsAccepted),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'I agree to the ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            TextSpan(
                              text: 'terms and conditions',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Add terms dialog
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Register button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF630606),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Login link
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Login here',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(context, LoginScreen.route);

                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameFields() {
    return Column(
      children: [
        TextFormFieldsWidget(
          title: "First Name",
          hintText: "Enter first name",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.person_outline,
          controller: _firstNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormFieldsWidget(
          title: "Middle Name",
          hintText: "Enter middle name",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.person_outline,
          controller: _middleNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormFieldsWidget(
          title: "Last Name",
          hintText: "Enter last name",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.person_outline,
          controller: _lastNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormFieldsWidget(
          title: "Username",
          hintText: "Enter username",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.person_outline,
          controller: _userNameController,
          focusNode: _userNameFocusNode,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            if (value.contains(' ')) {
              return 'No spaces allowed';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildContactFields() {
    return Column(
      children: [
        TextFormFieldsWidget(
          title: "Phone Number",
          hintText: "Enter phone",
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          focusNode: _phoneFocusNode,
          controller: _phoneController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
              return 'Only numbers allowed';
            }
            if (value.length != 11) {
              return 'Must be 11 digits';
            }
            if (!value.startsWith('09')) {
              return 'Must start with 09';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormFieldsWidget(
          title: "Email",
          hintText: "Enter email",
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          focusNode: _emailFocusNode,
          controller: _emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Invalid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Date of Birth',
              prefixIcon: Icon(Icons.calendar_today_outlined, color: Color(0xFF630606)),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF630606)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF630606), width: 2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                _selectedDate == null
                    ? 'Select date'
                    : DateFormat('MM/dd/yyyy').format(_selectedDate!),
                style: TextStyle(
                  color: _selectedDate == null ? Colors.grey[600] : Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter password",
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            if (value.length < 8) {
              return 'Minimum 8 characters';
            }
            if (!RegExp(r'[A-Z]').hasMatch(value)) {
              return '1 uppercase needed';
            }
            if (!RegExp(r'[a-z]').hasMatch(value)) {
              return '1 lowercase needed';
            }
            if (!RegExp(r'[0-9]').hasMatch(value)) {
              return '1 number needed';
            }
            if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
              return '1 special character needed';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            labelText: "Confirm Password",
            hintText: "Confirm password",
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            if (value != _passwordController.text) {
              return 'Passwords must match';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}