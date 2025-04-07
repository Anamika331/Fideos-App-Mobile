import 'package:shared_preferences/shared_preferences.dart';

class CookieManager{
  final String key;
  final String? value;

  CookieManager(this.key, {this.value});

  Future<bool> save() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value ?? "");
    return false;
  }

  Future<String?> get() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<bool> delete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}
