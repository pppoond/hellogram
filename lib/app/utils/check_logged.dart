import 'package:flutter/material.dart';
import 'package:hellogram/app/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLogged extends SharedPrefs {
  checkLogged() async {
    SharedPreferences pref = await prefs;
    var results = pref.getString("userIdPref");
    return results;
  }
}
