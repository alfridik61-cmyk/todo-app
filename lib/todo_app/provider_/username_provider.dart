import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_learning/toDo_app/homepage.dart';
import 'package:flutter_application_learning/todo_app/Auth_page/Auth_page.dart';
import 'package:flutter_application_learning/todo_app/user_data/userData.dart';
import 'package:flutter_application_learning/todo_app/widget_pages/profilepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsernameProvider with ChangeNotifier {
  String _username = 'jack';
  String get username => _username;
  bool _isloading = false;
  UserData? _userdata;
  bool get isloading => _isloading;
  UserData? get userData => _userdata;

  void setUsername(String newName) {
    _username = newName;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  Future<void> login({
    required context,
    required username,
    required password,
    required expiresInMins,
  }) async {
    try {
      final url = Uri.parse('https://dummyjson.com/auth/login');

      final response = await http.post(
        url,
        headers: {"Content-type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
          "expiresInMins": 1,
        }),
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // _username = data['username'];
        notifyListeners();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['accessToken']);
        // await prefs.setString('refresh_token', data['refreshToken']);
        String? accessToken = prefs.getString('access_token');
        // String? refreshToken = prefs.getString('refresh_token');

        if (accessToken != null && accessToken.isNotEmpty) {
          debugPrint("Token saved: $accessToken");
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Profilepage()),
        );
      } else {
        final errorMsg =
            jsonDecode(response.body)['message'] ?? "Failed to login";
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> userdata(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (accessToken == null && accessToken!.isEmpty) {
      debugPrint("no access token found");
      notifyListeners();
    }

    try {
      final url = Uri.parse('https://dummyjson.com/auth/me');
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $accessToken"},
      );
      // final decodeToken = jsonDecode(accessToken);
      // if(decodeToken.exp)
      if (response.statusCode == 200) {
        UserData userDataItem = UserData.fromJson(jsonDecode(response.body));
        _userdata = userDataItem;
        _username = userDataItem.username;
        debugPrint("user data : $_userdata");
        notifyListeners();
      } else if (response.statusCode == 401) {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.clear();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => AuthPage()),
        // );
        await refreshToken();
        return userdata(context);
      } else {
        debugPrint("Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
  }

  Future<void> refreshToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token');

      if (refreshToken == null || refreshToken.isEmpty) {
        debugPrint("No refresh token found");
        return;
      }

      final url = Uri.parse('https://dummyjson.com/auth/refresh');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"refreshToken": refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        await prefs.setString('access_token', data['accessToken']);
        await prefs.setString('refresh_token', data['refreshToken']);

        debugPrint("Tokens refreshed successfully!");
      } else {
        debugPrint(
          "Failed to refresh: ${response.statusCode} ${response.body}",
        );
      }
    } catch (e) {
      debugPrint("Exception in refreshToken: $e");
    }
  }
}
