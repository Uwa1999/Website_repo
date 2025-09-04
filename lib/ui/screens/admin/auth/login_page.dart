import 'dart:convert';
import 'dart:html' as html;
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/auth/registration_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/provider/user_provider.dart';
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
    _loadLoginAttemptState();
  }

  Future<void> _loadLoginAttemptState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      remainingAttempts = prefs.getInt('remainingAttempts') ?? 3;
      isUserLocked = prefs.getBool('isUserLocked') ?? false;
      lockoutMessage = prefs.getString('lockoutMessage');
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
  Future<bool> _validateEmail(String email) async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/admin-users/index'),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Debug print to see actual response
        print('Email validation response: $responseData');

        // Check if the response contains user data
        if (responseData.containsKey('data') && responseData['data'] is List) {
          final List<dynamic> users = responseData['data'];

          // Check if any user has this email
          return users.any((user) {
            final userEmail = user['email']?.toString().trim().toLowerCase();
            return userEmail == email.trim().toLowerCase();
          });
        }
      }

      // Debug print for failed cases
      print('Email validation failed for: $email');
      return false;
    } catch (e) {
      print('Error validating email: $e');
      return false;
    }
  }


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
            onPressed: () async {
              if (_emailController.text.isEmpty) {
                _showTopSnackBar('Please enter your email', isError: true);
                return;
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
                _showTopSnackBar('Please enter a valid email', isError: true);
                return;
              }

              // Show loading indicator
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );

              try {
                // First validate the email
                final isValidEmail = await _validateEmail(_emailController.text);
                if (!isValidEmail) {
                  Navigator.pop(context); // Close loading dialog
                  _showTopSnackBar('Email not found in our system', isError: true);
                  _emailController.clear();
                  return;
                }

                // If email is valid, send OTP
                final response = await http.post(
                  Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/auth/send-otp'),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'email': _emailController.text,
                  }),
                );

                Navigator.pop(context); // Close loading dialog

                if (response.statusCode == 201) {
                  final responseData = jsonDecode(response.body);
                  // Store the OTP from response for validation
                  final sentOtp = responseData['otp']?.toString(); // Adjust this based on actual response structure
                  print("-----------------------");
                  print(response.body);
                  Navigator.pop(context); // Close email dialog
                  _showOTPDialog(sentOtp: sentOtp); // Pass the OTP to the dialog
                  _showTopSnackBar(responseData['message'] ?? 'OTP sent successfully');
                  _emailController.clear();
                  print("response body: $responseData");
                } else {
                  final errorData = jsonDecode(response.body);
                  _showTopSnackBar(errorData['message'] ?? 'Failed to send OTP', isError: true);
                }
              } catch (e) {
                Navigator.pop(context); // Close loading dialog
                _showTopSnackBar('Failed to send OTP: ${e.toString()}', isError: true);
              }
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

  void _showOTPDialog({String? sentOtp}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verify OTP'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('OTP sent to ${_emailController.text}'),
            if (sentOtp != null)
              Text('Debug: OTP is $sentOtp', style: TextStyle(color: Colors.grey)),
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
              Navigator.pop(context); // Close OTP dialog
              _showChangePasswordDialog(); // Proceed directly to password change
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
      builder: (context) {
        // Local state for password visibility
        bool obscureNewPassword = true;
        bool obscureConfirmPassword = true;
        bool passwordsMatch = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Change Password'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // New Password Field
                    TextField(
                      controller: _newPasswordController,
                      obscureText: obscureNewPassword,
                      onChanged: (value) {
                        setState(() {
                          passwordsMatch = value == _confirmPasswordController.text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureNewPassword = !obscureNewPassword;
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
                      obscureText: obscureConfirmPassword,
                      onChanged: (value) {
                        setState(() {
                          passwordsMatch = value == _newPasswordController.text;
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
                                passwordsMatch ? Icons.check : Icons.close,
                                color: passwordsMatch ? Colors.green : Colors.red,
                                size: 20,
                              ),
                            IconButton(
                              icon: Icon(
                                obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureConfirmPassword = !obscureConfirmPassword;
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
                        passwordsMatch ? 'Passwords match' : 'Passwords do not match',
                        style: TextStyle(
                          color: passwordsMatch ? Colors.green : Colors.red,
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
                    backgroundColor: passwordsMatch &&
                        _newPasswordController.text.length >= 8 &&
                        _newPasswordController.text.contains(RegExp(r'[A-Z]')) &&
                        _newPasswordController.text.contains(RegExp(r'[a-z]')) &&
                        _newPasswordController.text.contains(RegExp(r'[0-9]')) &&
                        _newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
                        ? const Color(0xFF630606)
                        : Colors.grey,
                  ),
                  onPressed: passwordsMatch &&
                      _newPasswordController.text.length >= 8 &&
                      _newPasswordController.text.contains(RegExp(r'[A-Z]')) &&
                      _newPasswordController.text.contains(RegExp(r'[a-z]')) &&
                      _newPasswordController.text.contains(RegExp(r'[0-9]')) &&
                      _newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
                      ? _changePassword
                      : null,
                  child: const Text(
                    'Change Password',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
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

    try {
      final response = await http.post(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'otp': _otpController.text,
          'new_password': _newPasswordController.text,
        }),
      );

      // Close loading dialog
      Navigator.pop(context);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _showTopSnackBar(responseData['message'] ?? 'Password reset successfully!');

        // Clear all controllers
        _emailController.clear();
        _otpController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();

        // Close all dialogs
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        final errorData = jsonDecode(response.body);
        _showTopSnackBar(errorData['message'] ?? 'Failed to reset password', isError: true);
      }
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      _showTopSnackBar('Failed to reset password: ${e.toString()}', isError: true);
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

  Future<void> loginUser(String username, String password, BuildContext context) async {
    // Load preferences
    final prefs = await SharedPreferences.getInstance();

    // Clear lockout message only if not locked
    if (lockoutMessage != null || isUserLocked) {
      setState(() {
        lockoutMessage = null;
        isUserLocked = false;
      });
      await prefs.remove('isUserLocked');
      await prefs.remove('lockoutMessage');
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
        if (responseData['retCode'] == '201') {
          // ✅ Successful login - reset attempts
          setState(() {
            remainingAttempts = 3;
            isUserLocked = false;
            lockoutMessage = null;
          });

          await prefs.remove('remainingAttempts');
          await prefs.remove('isUserLocked');
          await prefs.remove('lockoutMessage');

          final adminUser = responseData['data']['admin_user'];
          final roleId = adminUser['role_id'].toString();
          final token = responseData['data']['jwt_token'];
          final username = adminUser['username'] ?? usernameController.text;

          // Save user info
          await prefs.setString('jwt_token', token);
          await prefs.setString('username', username);
          await prefs.setString('firstname', adminUser['firstname'] ?? '');
          await prefs.setString('lastname', adminUser['lastname'] ?? '');
          await prefs.setString('email', adminUser['email'] ?? '');
          await prefs.setString('role_id', roleId);

          final userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(
            username: username,
            firstname: adminUser['firstname'] ?? '',
            lastname: adminUser['lastname'] ?? '',
            email: adminUser['email'] ?? '',
            token: token,
            roleId: roleId,
          );

          if (roleId == '4') {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainScreen.route,
                  (route) => false,
            );
          } else {
            _showErrorDialog(context, 'You do not have permission to access this application.');
            usernameController.clear();
            passwordController.clear();
          }
        } else {
          // ❌ Login failed
          if (responseData['retCode'] == '401' && responseData['message']?.contains('User Locked') == true) {
            setState(() {
              isUserLocked = true;
              lockoutMessage = responseData['message'];
            });
            await prefs.setBool('isUserLocked', true);
            await prefs.setString('lockoutMessage', lockoutMessage!);
          } else {
            setState(() {
              remainingAttempts--;
            });
            await prefs.setInt('remainingAttempts', remainingAttempts);
            if (remainingAttempts <= 0) {
              setState(() {
                isUserLocked = true;
                lockoutMessage = "Too many failed attempts. You are locked out.";
              });
              await prefs.setBool('isUserLocked', true);
              await prefs.setString('lockoutMessage', lockoutMessage!);
            }
          }

          _showErrorDialog(context, responseData['message'] ?? 'Login failed');
          usernameController.clear();
          passwordController.clear();
        }
      } else {
        final errorData = jsonDecode(response.body);
        if (errorData['retCode'] == '401' && errorData['message']?.contains('User Locked') == true) {
          setState(() {
            isUserLocked = true;
            lockoutMessage = errorData['message'];
          });
          await prefs.setBool('isUserLocked', true);
          await prefs.setString('lockoutMessage', lockoutMessage!);
        } else {
          setState(() {
            remainingAttempts--;
          });
          await prefs.setInt('remainingAttempts', remainingAttempts);
          if (remainingAttempts <= 0) {
            setState(() {
              isUserLocked = true;
              lockoutMessage = "Too many failed attempts. You are locked out.";
            });
            await prefs.setBool('isUserLocked', true);
            await prefs.setString('lockoutMessage', lockoutMessage!);
          }
        }

        _showErrorDialog(context, errorData['message'] ?? 'Failed to connect to the server.');
        usernameController.clear();
        passwordController.clear();
      }
    } catch (e) {
      Navigator.pop(context);
      _showErrorDialog(context, 'An error occurred: $e');
      usernameController.clear();
      passwordController.clear();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
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
              // Background container - changed to gradient
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

              // Logo at top-left - simplified and matched to mobile style
              Positioned(
                top: 20,
                left: 20,
                child: ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    width: 200,
                    height: 90,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 15, top: 15),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.white, // Changed from AppColors.white to match mobile
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          'assets/images/fdsap.png',
                          width: 140,
                          height: 140,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Center login form - improved layout
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: size.width * 0.3,
                      constraints: BoxConstraints(
                        maxWidth: 400, // Added max width constraint
                        minHeight: size.height * 0.6,
                      ),
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
                                "V1.0",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black12,
                                 ),
                              ),
                              const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20), // Added for better spacing

                              // Staff ID Field
                              TextFormFieldsWidget(
                                title: "Username",
                                hintText: "Username",
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
                              const SizedBox(height: 15), // Added for better spacing

                              // Password Field
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
                                  // if (value.contains(' ')) {
                                  //   return 'Password cannot contain spaces';
                                  // }
                                  // if (!RegExp(r'[a-z]').hasMatch(value)) {
                                  //   return 'Must contain at least 1 lowercase letter';
                                  // }
                                  // if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                  //   return 'Must contain at least 1 uppercase letter';
                                  // }
                                  // if (!RegExp(r'[0-9]').hasMatch(value)) {
                                  //   return 'Must contain at least 1 number';
                                  // }
                                  // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>=]').hasMatch(value)) {
                                  //   return 'Must contain at least 1 special character';
                                  // }
                                  return null;
                                },
                              ),

                              // Lockout messages
                              // if (remainingAttempts < 3)
                              //   Padding(
                              //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                              //     child: Text(
                              //       'Remaining attempts: $remainingAttempts',
                              //       style: const TextStyle(
                              //         color: Colors.red,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ),

                              // Login Button
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF630606),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        loginUser(usernameController.text, passwordController.text, context);
                                      }
                                    },
                                    child: const Text(
                                      "LOGIN",
                                      style: TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Footer links
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Do not have an account? Click here to ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.8,
                                        color: Colors.black, // Changed from AppColors.black
                                        fontWeight: FontWeight.w100,
                                      ),
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
                                          Navigator.pushReplacementNamed(context, RegistrationForm.route);

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
                                        ..onTap = _handleForgotPassword,
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
          mobile: Stack(
            children: [
              // Background container
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF630606), Color(0xFF000000)],
                    ),
                  ),
                ),
              ),

              // Logo at top-left
              Positioned(
                top: 20,
                left: 20,
                child: SizedBox(
                  width: size.width * 0.5,
                  height: size.width * 0.2,
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

              // Center login form
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 400,
                      minHeight: size.height * 0.6,
                    ),
                    child: Container(
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Staff ID Field
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Staff ID",
                                  hintText: "Enter your Staff ID",
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                controller: usernameController,
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
                              const SizedBox(height: 15),

                              // Password Field
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  hintText: "Enter your password",
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        obscurePassword = !obscurePassword;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                obscureText: obscurePassword,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.go,
                                controller: passwordController,
                                onFieldSubmitted: (value) {
                                  if (formKey.currentState!.validate()) {
                                    loginUser(
                                      usernameController.text,
                                      passwordController.text,
                                      context,
                                    );
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  // if (value.contains(' ')) {
                                  //   return 'Password cannot contain spaces';
                                  // }
                                  // if (!RegExp(r'[a-z]').hasMatch(value)) {
                                  //   return 'Must contain at least 1 lowercase letter';
                                  // }
                                  // if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                  //   return 'Must contain at least 1 uppercase letter';
                                  // }
                                  // if (!RegExp(r'[0-9]').hasMatch(value)) {
                                  //   return 'Must contain at least 1 number';
                                  // }
                                  // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>=]').hasMatch(value)) {
                                  //   return 'Must contain at least 1 special character';
                                  // }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),

                              // Lockout message or remaining attempts
                              // if (remainingAttempts < 3)
                              //   Padding(
                              //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                              //     child: Text(
                              //       'Remaining attempts: $remainingAttempts',
                              //       style: const TextStyle(
                              //         color: Colors.red,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ),

                              // Login Button
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
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      loginUser(
                                        usernameController.text,
                                        passwordController.text,
                                        context,
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),

                              // Footer links
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Do not have an account? Click here to ',
                                    ),
                                    TextSpan(
                                      text: 'Create\n',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          if (kDebugMode) {
                                            print('-----Create Account Screen-----');
                                          }
                                          Navigator.pushReplacementNamed(context, RegistrationForm.route);

                                        },
                                    ),
                                    const TextSpan(
                                      text: 'Forgot Password? ',
                                    ),
                                    TextSpan(
                                      text: 'Click here',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _handleForgotPassword,
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