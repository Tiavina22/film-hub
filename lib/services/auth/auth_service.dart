import 'dart:convert';
import 'package:filmhub/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthService {
  final String baseUrl = 'http://localhost:3000/api/auth';
  final storage = const FlutterSecureStorage();

  Future<User> signIn(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      await storage.write(key: 'token', value: user.accessToken);
      return user;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> signUp({
    required String nom,
    required String prenom,
    required String username,
    required String password,
    required int age,
    required String genre,
    required String pays,
    required String region,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nom': nom,
        'prenom': prenom,
        'username': username,
        'password': password,
        'age': age,
        'genre': genre,
        'pays': pays,
        'region': region,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
}