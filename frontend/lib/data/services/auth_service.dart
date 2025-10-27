import 'api_service.dart';
import '../../config/api_endpoints.dart';
import '../models/user_model.dart';

class AuthService {
  final ApiService api = ApiService();

  Future<UserModel> login(String email, String password) async {
    final data = await api.post(ApiEndpoints.authLogin, {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(data['user']);
  }

  Future<UserModel> register(String name, String email, String password) async {
    final data = await api.post(ApiEndpoints.authRegister, {
      'name': name,
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(data['user']);
  }
}
