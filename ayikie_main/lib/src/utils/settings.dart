import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static clearAll() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();
  }

  static setAccessToken(String token) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("access_token", token);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? token = sharedPrefs.getString("access_token");
    return token;
  }

  static setUserRole(String role) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("role", role);
  }

  static Future<String?> getUserRole() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? role = sharedPrefs.getString("role");
    return role;
  }
}
