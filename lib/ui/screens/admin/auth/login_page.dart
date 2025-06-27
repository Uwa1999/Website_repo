import 'dart:convert';
import 'dart:html' as html;
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/auth/registration_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/admin_widgets/text_form_field_widget.dart';
import '../../shared/utils/responsive.dart';
import '../../shared/values/colors.dart';
import '../homepage/main_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/Admin/Login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode _keyboardFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // Forgot Password Controllers
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _passwordsMatch = false;

  // Track login attempts
  int remainingAttempts = 3;
  String? lockoutMessage;
  bool isUserLocked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _usernameFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _keyboardFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    usernameController.dispose();
    passwordController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Forgot Password Methods
  void _handleForgotPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please enter your email address to receive an OTP'),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF630606),
            ),
            onPressed: () {
              if (_emailController.text.isEmpty) {
                _showTopSnackBar('Please enter your email', isError: true);
                return;
              }
              Navigator.pop(context);
              _showOTPDialog();
            },
            child: const Text(
              'Send OTP',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showOTPDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verify OTP'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('OTP sent to ${_emailController.text}'),
            const SizedBox(height: 16),
            TextFormField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF630606),
            ),
            onPressed: () {
              if (_otpController.text.isEmpty) {
                _showTopSnackBar('Please enter the OTP', isError: true);
                return;
              }
              Navigator.pop(context);
              _showChangePasswordDialog();
            },
            child: const Text(
              'Verify',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // New Password Field
              TextField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                onChanged: (value) {
                  setState(() {
                    _passwordsMatch = value == _confirmPasswordController.text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Password Requirements
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Password Requirements:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildRequirementRow(
                    'At least 8 characters',
                    _newPasswordController.text.length >= 8,
                    _newPasswordController.text.isNotEmpty,
                  ),
                  _buildRequirementRow(
                    '1 uppercase letter (A-Z)',
                    _newPasswordController.text.contains(RegExp(r'[A-Z]')),
                    _newPasswordController.text.isNotEmpty,
                  ),
                  _buildRequirementRow(
                    '1 lowercase letter (a-z)',
                    _newPasswordController.text.contains(RegExp(r'[a-z]')),
                    _newPasswordController.text.isNotEmpty,
                  ),
                  _buildRequirementRow(
                    '1 number (0-9)',
                    _newPasswordController.text.contains(RegExp(r'[0-9]')),
                    _newPasswordController.text.isNotEmpty,
                  ),
                  _buildRequirementRow(
                    '1 special character (!@#...)',
                    _newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                    _newPasswordController.text.isNotEmpty,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Confirm Password Field
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                onChanged: (value) {
                  setState(() {
                    _passwordsMatch = value == _newPasswordController.text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_confirmPasswordController.text.isNotEmpty)
                        Icon(
                          _passwordsMatch ? Icons.check : Icons.close,
                          color: _passwordsMatch ? Colors.green : Colors.red,
                          size: 20,
                        ),
                      IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Password Match Indicator
              if (_confirmPasswordController.text.isNotEmpty)
                Text(
                  _passwordsMatch ? 'Passwords match' : 'Passwords do not match',
                  style: TextStyle(
                    color: _passwordsMatch ? Colors.green : Colors.red,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _passwordsMatch &&
                  _newPasswordController.text.length >= 8 &&
                  _newPasswordController.text.contains(RegExp(r'[A-Z]')) &&
                  _newPasswordController.text.contains(RegExp(r'[a-z]')) &&
                  _newPasswordController.text.contains(RegExp(r'[0-9]')) &&
                  _newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
                  ? const Color(0xFF630606)
                  : Colors.grey,
            ),
            onPressed: _passwordsMatch &&
                _newPasswordController.text.length >= 8 &&
                _newPasswordController.text.contains(RegExp(r'[A-Z]')) &&
                _newPasswordController.text.contains(RegExp(r'[a-z]')) &&
                _newPasswordController.text.contains(RegExp(r'[0-9]')) &&
                _newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
                ? () {
              _changePassword();
              Navigator.pop(context);
            }
                : null,
            child: const Text(
              'Change Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool isMet, bool hasInput) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.error,
          size: 16,
          color: !hasInput ? Colors.grey : (isMet ? Colors.green : Colors.red),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: !hasInput ? Colors.grey : (isMet ? Colors.green : Colors.red),
          ),
        ),
      ],
    );
  }

  Future<void> _changePassword() async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Close loading dialog
    Navigator.pop(context);

    // Show success message
    _showTopSnackBar('Password changed successfully!');

    // Clear all controllers
    _emailController.clear();
    _otpController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
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

  Future<void> loginUser(String username, String password, BuildContext context) async {
    // Clear previous lockout message if any
    if (lockoutMessage != null || isUserLocked) {
      setState(() {
        lockoutMessage = null;
        isUserLocked = false;
      });
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              const Text('FDSAP WEBSITE'),
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/fdsap.png',
                width: MediaQuery.of(context).size.width > 600 ? 120 : 80,
                height: MediaQuery.of(context).size.width > 600 ? 120 : 80,
              ),
            ],
          ),
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 25),
              Text('LOGGING IN...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
        );
      },
    );

    try {
      final url = Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/auth/signin');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'username': username,
        'password': password,
      });

      final response = await http.post(url, headers: headers, body: body);
      Navigator.pop(context); // Dismiss loading dialog

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['retCode'] == '200') {
          // Successful login - reset attempts
          setState(() {
            remainingAttempts = 3;
            isUserLocked = false;
          });

          final adminUser = responseData['data']['admin_user'];
          final roleId = adminUser['role_id'].toString();
          final token = responseData['data']['jwt_token'];
          final username = adminUser['username'] ?? usernameController.text;

          // Store the token and username
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt_token', token);
          await prefs.setString('username', username);
          await prefs.setString('firstname', adminUser['firstname'] ?? '');
          await prefs.setString('lastname', adminUser['lastname'] ?? '');
          await prefs.setString('email', adminUser['email'] ?? '');

          if (roleId == '4') { // Admin role check
            if (kIsWeb) {
              html.window.history.pushState(null, '', '/home');
            }

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  userData: adminUser,
                ),
              ),
                  (Route<dynamic> route) => false,
            );
          } else {
            _showErrorDialog(context, 'You do not have permission to access this application.');
          }
        } else {
          // Check if user is locked from the API response
          if (responseData['retCode'] == '401' && responseData['message']?.contains('User Locked') == true) {
            setState(() {
              isUserLocked = true;
              lockoutMessage = responseData['message'];
            });
          } else {
            // Regular failed attempt
            setState(() {
              remainingAttempts--;
            });
          }

          _showErrorDialog(context, responseData['message'] ?? 'Login failed');
          passwordController.clear();
        }
      } else {
        final errorData = jsonDecode(response.body);
        // Check if user is locked from the API response
        if (errorData['retCode'] == '401' && errorData['message']?.contains('User Locked') == true) {
          setState(() {
            isUserLocked = true;
            lockoutMessage = errorData['message'];
          });
        } else {
          // Regular failed attempt
          setState(() {
            remainingAttempts--;
          });
        }

        _showErrorDialog(context, errorData['message'] ?? 'Failed to connect to the server. Please try again later.');
        passwordController.clear();
      }
    } catch (e) {
      Navigator.pop(context);
      _showErrorDialog(context, 'An error occurred: $e');
      passwordController.clear();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF630606).withOpacity(0.50),
      body: RawKeyboardListener(
        focusNode: _keyboardFocusNode,
        autofocus: true,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.enter) {
            if (formKey.currentState!.validate()) {
              loginUser(usernameController.text, passwordController.text, context);
            }
          }
        },
        child: Responsive(
          desktop: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: size.width,
                      height: size.height,
                      decoration: const BoxDecoration(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    width: 200,
                    height: 90,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 15, top: 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                            child: Image.asset(
                              'assets/images/fdsap.png',
                              width: 140,
                              height: 140,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: size.width * 0.3,
                      height: size.height * 0.6,
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
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Login",
                                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              TextFormFieldsWidget(
                                title: "Staff ID",
                                hintText: "Staff ID",
                                prefixIcon: Icons.person_outline,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                controller: usernameController,
                                accountNumberField: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  if (value.contains(' ')) {
                                    return 'Username cannot contain spaces';
                                  }
                                  return null;
                                },
                              ),
                              TextFormFieldsWidget(
                                title: "Password",
                                hintText: "Password",
                                obscureText: obscurePassword,
                                prefixIcon: Icons.lock_outline,
                                suffixIcon: obscurePassword ? Icons.visibility : Icons.visibility_off,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.go,
                                controller: passwordController,
                                accountNumberField: false,
                                onFieldSubmitted: (value) {
                                  if (formKey.currentState!.validate()) {
                                    loginUser(usernameController.text, passwordController.text, context);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.contains(' ')) {
                                    return 'Password cannot contain spaces';
                                  }
                                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                                    return 'Must contain at least 1 lowercase letter';
                                  }
                                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                    return 'Must contain at least 1 uppercase letter';
                                  }
                                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                                    return 'Must contain at least 1 number';
                                  }
                                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>=]').hasMatch(value)) {
                                    return 'Must contain at least 1 special character';
                                  }
                                  return null;
                                },
                              ),
                              if (isUserLocked)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    lockoutMessage ?? 'User account is locked',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              else if (remainingAttempts < 3)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Remaining attempts: $remainingAttempts',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isUserLocked ? Colors.grey : const Color(0xFF630606),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: isUserLocked
                                        ? null
                                        : () {
                                      if (formKey.currentState!.validate()) {
                                        loginUser(usernameController.text, passwordController.text, context);
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(fontSize: 15, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Do not have an account? Click here to ',
                                      style: TextStyle(fontSize: 13, height: 1.8, color: AppColors.black, fontWeight: FontWeight.w100),
                                    ),
                                    TextSpan(
                                      text: 'Create\n',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        height: 1.8,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          if (kDebugMode) {
                                            print('-----Create Account Screen-----');
                                          }
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationForm()));
                                        },
                                    ),
                                    TextSpan(
                                      text: 'Forgot Password?',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        height: 1.8,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _handleForgotPassword, // Updated to use the new method
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          mobile: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  width: size.width,
                  height: size.height * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Image.asset("assets/images/splash_screen/mini_logo.png"),
                          const SizedBox(height: 10),
                          const Text(
                            "Tracking System",
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Track your package in real time",
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 30),
                          TextFormFieldsWidget(
                            title: "Staff ID or Username",
                            hintText: "Username",
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.none,
                            textInputAction: TextInputAction.next,
                            controller: usernameController,
                            accountNumberField: false,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return '';
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormFieldsWidget(
                            title: "Password",
                            hintText: "Password",
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: obscurePassword ? Icons.visibility : Icons.visibility_off,
                            keyboardType: TextInputType.none,
                            textInputAction: TextInputAction.next,
                            controller: passwordController,
                            accountNumberField: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please input your password.';
                              } else {
                                return null;
                              }
                            },
                          ),
                          if (isUserLocked)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                lockoutMessage ?? 'User account is locked',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          else if (remainingAttempts < 3)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Remaining attempts: $remainingAttempts',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: isUserLocked ? Colors.grey : Colors.white,
                                border: Border.all(color: isUserLocked ? Colors.grey : Colors.green),
                              ),
                              child: MaterialButton(
                                onPressed: isUserLocked
                                    ? null
                                    : () {
                                  if (formKey.currentState!.validate()) {
                                    loginUser(usernameController.text, passwordController.text, context);
                                  }
                                },
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isUserLocked ? Colors.white : Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Do not have an account? Click here to ',
                                  style: TextStyle(fontSize: 13, height: 1.8, color: AppColors.black, fontWeight: FontWeight.w100),
                                ),
                                TextSpan(
                                  text: 'Create\n',
                                  style: const TextStyle(fontSize: 13, height: 1.8, color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      if (kDebugMode) {
                                        print('-----Create Account Screen-----');
                                      }
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationForm()));
                                    },
                                ),
                                TextSpan(
                                  text: 'Forgot Password?',
                                  style: const TextStyle(fontSize: 13, height: 1.8, color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _handleForgotPassword, // Updated to use the new method
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  final double customHeight;
  final double radius;

  CustomClipPath({this.customHeight = 70.0, this.radius = 20.0});

  @override
  Path getClip(Size size) {
    Path path = Path();

    double height = customHeight;

    path.moveTo(0, radius);
    path.arcToPoint(Offset(radius, 2), radius: Radius.circular(radius));

    double c1x = size.width * 1;
    double c1y = -radius;
    double e1x = size.width;
    double e1y = 1.6;
    path.quadraticBezierTo(c1x, c1y, e1x, e1y);

    path.lineTo(size.width, height - radius);

    path.arcToPoint(Offset(size.width - radius, height), radius: Radius.circular(radius));

    path.lineTo(0, height);
    path.arcToPoint(Offset(0, height - radius), radius: Radius.circular(radius));

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}