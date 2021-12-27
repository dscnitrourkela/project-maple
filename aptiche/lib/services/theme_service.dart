import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxController {
  final GetStorage _getStorage = GetStorage();
  final String _isDarkModeKey = 'isDarkMode';
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    isDarkMode.value = _getStorage.read<bool>(_isDarkModeKey) ?? false;
    super.onInit();
  }

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  /// Save isDarkMode to local storage
  void _saveThemeToBox(bool isDarkMode) async =>
      await _getStorage.write(_isDarkModeKey, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme() {
    isDarkMode.value = !isDarkMode.value;

    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToBox(isDarkMode.value);
  }
}
