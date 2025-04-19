import 'package:shared_preferences/shared_preferences.dart';

class SharedUserData {
  Future<void> saveUserInfo(String username, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('name', name);
  }

  Future<Map<String, String?>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final name = prefs.getString('name');

    return {"username": username, "name": name};
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('name');
  }
}
