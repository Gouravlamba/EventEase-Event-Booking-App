import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  bool _loading = false;


  AuthProvider() {
   
    _user = null; 
  }

  UserModel? get user => _user;

 
  bool get isAuthenticated => true;

  bool get loading => _loading;

  Future<void> login(String email, String password) async {
    _loading = true;
    notifyListeners();
    try {
      _user = await _authService.login(email, password);
    } catch (e) {
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> register(String name, String email, String password) async {
    _loading = true;
    notifyListeners();
    try {
      _user = await _authService.register(name, email, password);
    } catch (e) {
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
