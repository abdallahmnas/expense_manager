import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> setProfile(data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('profile', jsonEncode(data)).then((bool success) {
    // return success;
    print(success);
  });
}


getProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get('profile').toString();
}

removeProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('profile');
  return true;
}