// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<dynamic>> getUsers() async {
    final response =
        await http.get(Uri.parse('http://localhost:44387/api/Users'));
    if (response.statusCode == 200) {
      // 200 status code is OK, it assumes that the request was successful
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('User Not Found');
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<Map<String, dynamic>> getUserById(int Id) async {
    final response =
        await http.get(Uri.parse('http://localhost:44387/api/Users/$Id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('User Not Found');
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('http://localhost:44387/api/Users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
  }

  Future<void> updateUser(int Id, Map<String, dynamic> userData) async {
    final response = await http.put(
      Uri.parse('http://localhost:44387/api/Users/$Id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to update User');
    }
  }

  Future<void> deleteUser(int Id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:44387/api/Users/$Id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }
}
