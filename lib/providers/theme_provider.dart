import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _Dark_theme=false;
  bool get Isdark_theme => _Dark_theme;
  static const String key='theme';
ThemeProvider(){
  getTheme();
}

  /// Sets the dark theme value and updates the shared preferences.
  ///
  /// This function updates the [_Dark_theme] variable with the provided value.
  /// It also updates the shared preferences with the new value.
  /// It notifies the listeners of the theme change.
  ///
  /// The [value] parameter is a boolean that represents the new dark theme value.
  ///
  /// Returns a Future that completes when the shared preferences are updated.
  Future<void> setdarkTheme({required bool value}) async {
    // Get the shared preferences instance.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Update the shared preferences with the new value.
    prefs.setBool(key, value);

    // Update the dark theme value.
    _Dark_theme = value;

    // Notify the listeners of the theme change.
    notifyListeners();
  }

  /// Retrieves the current theme from the shared preferences.
  ///
  /// This function checks if the theme key exists in the shared preferences.
  /// If it does, it retrieves the value and updates the [_Dark_theme] variable.
  /// It then notifies the listeners.
  /// If the key does not exist, it returns the current value of [_Dark_theme].
  ///
  /// Returns a Future<bool> that represents the current theme.
  Future<bool> getTheme() async {
    // Get the shared preferences instance.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the theme key exists in the shared preferences.
    if (prefs.containsKey(key)) {
      // If the key exists, retrieve the value and update the theme variable.
      _Dark_theme = prefs.getBool(key)!;
      // Notify the listeners of the theme change.
      notifyListeners();
    }

    // Return the current theme.
    return _Dark_theme;
  }
}