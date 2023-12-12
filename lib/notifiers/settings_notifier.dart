import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums/settings.dart';

class SettingsNotifier extends ChangeNotifier {
  Map<Settings, bool> displayOptions = {
    Settings.englishFirst: true,
    Settings.showPinyin: true,
    Settings.audioOnly: false,
  };

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    displayOptions = {
      Settings.englishFirst: prefs.getBool(Settings.englishFirst.name) ?? true,
      Settings.showPinyin: prefs.getBool(Settings.showPinyin.name) ?? true,
      Settings.audioOnly: prefs.getBool(Settings.audioOnly.name) ?? false,
    };
    notifyListeners();
  }

  void updateDisplayOptions({required Settings displayOption, required bool isToggled}) {
    displayOptions.update(displayOption, (value) => isToggled);
    _savePreference(displayOption, isToggled);
    notifyListeners();
  }

  void resetSettings() {
    displayOptions = {
      Settings.englishFirst: true,
      Settings.showPinyin: true,
      Settings.audioOnly: false,
    };
    _clearPreferences();
    notifyListeners();
  }

  Future<void> _savePreference(Settings setting, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(setting.name, value);
  }

  Future<void> _clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    for (var setting in Settings.values) {
      prefs.remove(setting.name);
    }
  }
}
