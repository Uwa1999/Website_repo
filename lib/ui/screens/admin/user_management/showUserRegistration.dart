import 'dart:convert';

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/singleButtonDialog.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/textFormField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../core/provider/user_provider.dart';

void userRegistration(BuildContext context, Function() refreshList) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => UserRegistration(refreshList: refreshList,));
}

class UserRegistration extends StatefulWidget {
  final Function() refreshList;
  const UserRegistration({super.key, required this.refreshList});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _mnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  bool _termsAccepted = false;
  bool showErrors = false;
  bool isLoading = false;

  void clearFields() async {
    _fnameController.clear();
    _mnameController.clear();
    _lnameController.clear();
    _usernameController.clear();
    _mobileController.clear();
    _birthdayController.clear();
    _roleController.clear();
    _emailController.clear();
    _passwordController.clear();
    _cpasswordController.clear();
  }

  Future<void> _submitForm() async {
    if (_termsAccepted) {
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

      final requestBody = {
        "email": _emailController.text,
        "mobile": _mobileController.text,
        "username": _usernameController.text,
        "password": _passwordController.text,
        "firstname": _fnameController.text,
        "middlename": _mnameController.text,
        "lastname": _lnameController.text,
        "birthday": _birthdayController.text,
        "role_name": _roleController.text
      };

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.token;

      try {
        final response = await http.post(
          Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/auth/signup'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(requestBody),
        );
        Navigator.of(context).pop();

        final responseData = jsonDecode(response.body);

        if (responseData['retCode'] == '200') {
          singleButtonDialog(
            context,
            message: responseData['message'],
            title: 'Success',
            icon: Icons.check_circle,
            onPressed: () {
              clearFields();
              Navigator.of(context).pop();
            },
          );
          widget.refreshList();
        } else {
          singleButtonDialog(
            context,
            message: responseData['message'],
            title: 'Error',
            icon: Icons.error,
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }
      } catch (e) {
        print('Error $e');
        Navigator.of(context).pop();
        singleButtonDialog(
          context,
          message: 'An error occurred. Please try again.',
          title: 'Error',
          icon: Icons.error,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1.0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.60,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                    color: Color(0xFF4B0C0C)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.clear, size: 20, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'USER REGISTRATION',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2.0),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 400,
                            child: EncodingFields(
                              controller: _fnameController,
                              hintText: 'First Name',
                              readonly: false,
                              showError: showErrors,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "First Name is required";
                                }
                                if (RegExp(r'[0-9]').hasMatch(value)) {
                                  return "First Name cannot contain numbers";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 400,
                            child: EncodingFields(
                              controller: _birthdayController,
                              hintText: 'Date of Birth',
                              readonly: false,
                              showError: showErrors,
                              datepicker: true,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Birthday is required";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 400,
                            child: EncodingFields(
                              controller: _mnameController,
                              hintText: 'Middle Name',
                              readonly: false,
                              showError: showErrors,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Middle Name is required";
                                }
                                if (RegExp(r'[0-9]').hasMatch(value)) {
                                  return "Middle Name cannot contain numbers";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 400,
                            child: EncodingFields(
                              controller: _mobileController,
                              hintText: 'Mobile Number',
                              readonly: false,
                              showError: showErrors,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Mobile number is required";
                                }
                                final numericRegex = RegExp(r'^\d{11}$');
                                if (!numericRegex.hasMatch(value)) {
                                  return "Enter a valid 11-digit mobile number";
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 400,
                            child: EncodingFields(
                              controller: _lnameController,
                              hintText: 'Last Name',
                              readonly: false,
                              showError: showErrors,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Last Name is required";
                                }
                                if (RegExp(r'[0-9]').hasMatch(value)) {
                                  return "Last Name cannot contain numbers";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 400,
                            child: EncodingFields(
                              controller: _emailController,
                              hintText: 'Email Address',
                              readonly: false,
                              showError: showErrors,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Email is required";
                                }
                                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 400,
                            child: EncodingFields(
                              controller: _roleController,
                              hintText: 'Role',
                              readonly: false,
                              dropdown: true,
                              dropdownParam: 'roles',
                              showError: showErrors,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Role is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 400,
                            child: EncodingFields(
                              controller: _passwordController,
                              hintText: 'Password',
                              readonly: false,
                              showError: showErrors,
                              obscure: true,
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
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 400,
                            child: EncodingFields(
                              controller: _usernameController,
                              hintText: 'Username',
                              readonly: false,
                              showError: showErrors,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Username is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 400,
                            child: EncodingFields(
                              controller: _cpasswordController,
                              hintText: 'Confirm Password',
                              readonly: false,
                              showError: showErrors,
                              obscure: true,
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 810,
                            child: Row(
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
                                            text: 'Terms and Conditions',
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 13,
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 810, // Same width as the field rows
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF630606),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 15),
                              ),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                  showErrors = true;
                                });
                                final isValid = [
                                  _fnameController,
                                  _mnameController,
                                  _lnameController,
                                  _usernameController,
                                  _emailController,
                                  _mobileController,
                                  _birthdayController,
                                  _roleController,
                                  _passwordController,
                                  _cpasswordController
                                ].every((controller) => controller.text.trim().isNotEmpty);
                                print('Is form valid? $isValid');
                                if (!isValid) return;
                                _submitForm();
                              },
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}