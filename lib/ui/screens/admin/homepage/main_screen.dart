import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/admin_widgets/dashboard_appbar_widget.dart';
import '../../shared/admin_widgets/side_bar_widget.dart';
import '../auth/login_page.dart';
import '../catalogs/products_and_services.dart';
import '../insights/add_insight.dart';
import 'dashboard_screen.dart';


class MainScreen extends StatefulWidget {
  static const String route = '/Admin/MainScreen';

  final Map<String, dynamic>? userData;

  const MainScreen({super.key, this.userData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _selectedItem = 'dashboard';
  bool _isSidebarVisible = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog();
    });
  }
  Future<void> _performLogout() async {
    // Show confirmation dialog
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) return;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Logging out...'),
            ],
          ),
        );
      },
    );

    try {
      // Clear user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('role');
      await prefs.remove('staffID');
      await prefs.remove('selectedIndex');
      await prefs.remove('jwt_token');

      await Future.delayed(const Duration(milliseconds: 1000));

      // For web - clear session storage
      if (kIsWeb) {
        html.window.sessionStorage.clear();
      }

      // Close loading dialog
      if (mounted) Navigator.of(context).pop();

      // Navigate to login screen
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      // Close loading dialog if there's an error
      if (mounted) Navigator.of(context).pop();

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout failed. Please try again.')),
        );
      }
    }
  }

  Future<void> _changePassword({
    required String username,
    required String oldPassword,
    required String newPassword,
  }) async {
    const String apiUrl = 'https://dev-api-janus.fortress-asya.com:18043/api/public/v1/auth/change-password';

    try {
      // Get the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token == null) {
        _showTopSnackBar('Authentication token not available. Please log in again.', isError: true);
        return;
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Use the token from SharedPreferences
        },
        body: jsonEncode({
          'username': username,
          'oldPassword': oldPassword,
          'password': newPassword,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _showTopSnackBar(responseData['message'] ?? 'Password changed successfully');
      } else {
        _showTopSnackBar(responseData['message'] ?? 'Failed to change password', isError: true);

        // If token is invalid/expired, you might want to force logout
        if (response.statusCode == 401) {
          // Clear stored credentials
          await prefs.remove('jwt_token');
          await prefs.remove('username');
          // Navigate back to login
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
          );
        }
      }
    } catch (e) {
      _showTopSnackBar('An error occurred: ${e.toString()}', isError: true);
    }
  }
  void _showChangePasswordDialog() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    bool obscureCurrentPassword = true;
    bool obscureNewPassword = true;
    bool obscureConfirmPassword = true;
    bool passwordsMatch = false;
    bool allRequirementsMet = false;

    // Check all password requirements
    void checkPasswordRequirements(String password) {
      final hasMinLength = password.length >= 8;
      final hasUppercase = password.contains(RegExp(r'[A-Z]'));
      final hasLowercase = password.contains(RegExp(r'[a-z]'));
      final hasNumber = password.contains(RegExp(r'[0-9]'));
      final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      setState(() {
        allRequirementsMet = hasMinLength &&
            hasUppercase &&
            hasLowercase &&
            hasNumber &&
            hasSpecialChar;
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Change Password'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Current Password Field
                    TextField(
                      controller: currentPasswordController,
                      obscureText: obscureCurrentPassword,
                      decoration: InputDecoration(
                        labelText: 'Current Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureCurrentPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureCurrentPassword = !obscureCurrentPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // New Password Field
                    TextField(
                      controller: newPasswordController,
                      obscureText: obscureNewPassword,
                      onChanged: (value) {
                        checkPasswordRequirements(value);
                        setState(() {
                          passwordsMatch = value == confirmPasswordController.text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureNewPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                          newPasswordController.text.length >= 8,
                          newPasswordController.text.isNotEmpty,
                        ),
                        _buildRequirementRow(
                          '1 uppercase letter (A-Z)',
                          newPasswordController.text.contains(RegExp(r'[A-Z]')),
                          newPasswordController.text.isNotEmpty,
                        ),
                        _buildRequirementRow(
                          '1 lowercase letter (a-z)',
                          newPasswordController.text.contains(RegExp(r'[a-z]')),
                          newPasswordController.text.isNotEmpty,
                        ),
                        _buildRequirementRow(
                          '1 number (0-9)',
                          newPasswordController.text.contains(RegExp(r'[0-9]')),
                          newPasswordController.text.isNotEmpty,
                        ),
                        _buildRequirementRow(
                          '1 special character (!@#...)',
                          newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                          newPasswordController.text.isNotEmpty,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password Field
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: obscureConfirmPassword,
                      onChanged: (value) {
                        setState(() {
                          passwordsMatch = value == newPasswordController.text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (confirmPasswordController.text.isNotEmpty)
                              Icon(
                                passwordsMatch ? Icons.check : Icons.close,
                                color: passwordsMatch ? Colors.green : Colors.red,
                                size: 20,
                              ),
                            IconButton(
                              icon: Icon(
                                obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
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
                    if (confirmPasswordController.text.isNotEmpty)
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
                    backgroundColor: allRequirementsMet && passwordsMatch
                        ? const Color(0xFF630606)
                        : Colors.grey,
                  ),
                  onPressed: allRequirementsMet && passwordsMatch
                      ? () async {
                    // Validate current password is not empty
                    if (currentPasswordController.text.isEmpty) {
                      _showTopSnackBar('Please enter your current password', isError: true);
                      return;
                    }

                    // Get username from userData
                    final username = widget.userData?['username'];
                    if (username == null || username.isEmpty) {
                      _showTopSnackBar('User information not available', isError: true);
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

                    // Call the API
                    await _changePassword(
                      username: username,
                      oldPassword: currentPasswordController.text,
                      newPassword: newPasswordController.text,
                    );

                    // Close both dialogs
                    Navigator.of(context).pop(); // Close loading dialog
                    Navigator.of(context).pop(); // Close password change dialog
                  }
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

// Helper widget for requirement rows
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

  void _showWelcomeDialog() {
    if (widget.userData != null) {
      final firstName = widget.userData!['firstname'] ?? 'User';
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Welcome!'),
            content: Text('Hello, $firstName! You have successfully logged in.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Continue'),
              ),
            ],
          );
        },
      );
    }
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  void _handleSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Widget _getContent() {
    switch (_selectedItem) {
      case 'dashboard':
        return DashboardScreen(searchQuery: _searchQuery);
      case 'insights':
        return const AddInsightForm();
      case 'products & services':
        return const ProductsAndServices();
      default:
        return DashboardScreen(searchQuery: _searchQuery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (_isSidebarVisible)
            SizedBox(
              width: 220,
              child: SideNavigation(
                onItemSelected: (item) {
                  setState(() {
                    _selectedItem = item;
                  });
                },
                selectedItem: _selectedItem,
                onToggleSidebar: _toggleSidebar,
                // onLogout: () {}, // This can be empty now since we handle logout internally
              ),
            ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (!_isSidebarVisible)
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: _toggleSidebar,
                        ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DashboardAppBar(
                          onSearchChanged: _handleSearchChanged,
                          isEnabled: _selectedItem == 'dashboard',
                          username: widget.userData?['username'] ??
                              widget.userData?['firstname'] ??
                              'User',
                          onChangePasswordPressed: _showChangePasswordDialog,
                          onLogout: _performLogout,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _getContent(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}