import 'package:shared_preferences/shared_preferences.dart';

class SharedFunctions {
  static String loggedInKey = "LOGGEDINKEY";
  static String usernameKey = "USERNAMEKEY";
  static String usermailKey = "USERMAILKEY";

  static Future<bool> saveLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(loggedInKey, isLoggedIn);
  }

  static Future<bool> saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(usernameKey, username);
  }

  static Future<bool> saveUsermail(String usermail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(usermailKey, usermail);
  }

  static Future<bool> sharedLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedInKey);
  }

  static Future<String> sharedUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(usernameKey);
  }

  static Future<String> sharedUsermail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(usermailKey);
  }
}
