class ApiEndpoints {
  // Replace with your backend address
  static const String baseUrl = 'http://10.0.2.2:4000/api'; // Android emulator default to host
  static const String authRegister = '$baseUrl/auth/register';
  static const String authLogin = '$baseUrl/auth/login';
  static const String events = '$baseUrl/events';
  static const String bookings = '$baseUrl/bookings';
  static const String admin = '$baseUrl/admin';
}
