import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? _username;
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _token;
  String? _roleId;
  String? _roleName;

  // Getters
  String? get username => _username;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get email => _email;
  String? get token => _token;
  String? get roleId => _roleId;
  String? get roleName => _roleName;

  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  void setUser({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String token,
    required String roleId,
    required String roleName,
  }) {
    _username = username;
    _firstname = firstname;
    _lastname = lastname;
    _email = email;
    _token = token;
    _roleId = roleId;
    _roleName = roleName;
    notifyListeners();
  }

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username');
    _firstname = prefs.getString('firstname');
    _lastname = prefs.getString('lastname');
    _email = prefs.getString('email');
    _token = prefs.getString('jwt_token');
    _roleId = prefs.getString('role_id');
    _roleName = prefs.getString('role_name');
    notifyListeners();
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _username = null;
    _firstname = null;
    _lastname = null;
    _email = null;
    _token = null;
    _roleId = null;
    _roleName = null;
    notifyListeners();
  }
}
