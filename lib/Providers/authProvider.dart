import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _email;
  bool _isLoading = false;

  String? get token => _token;
  String? get email => _email;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _token = data['access_token'];

        // Save token and email to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setString('email', email);

        _email = email;

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Logged In Successfully'),
          duration: Duration(seconds: 2),
        ));
        notifyListeners();
      } else {
        _showErrorMessage(context,);
      }
    } catch (e) {
      _showErrorMessage(context);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showErrorMessage(BuildContext context, ) {
    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
      content: Text('Login Failed'),
      duration:  Duration(seconds: 2),
    ));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('email');
    _token = null;
    _email = null;
    notifyListeners();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _email = prefs.getString('email');
    notifyListeners();
  }
}
