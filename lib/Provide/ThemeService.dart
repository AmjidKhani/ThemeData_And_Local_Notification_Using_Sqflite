import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService
{
final _b =GetStorage();
final _key="isDarkMode";
saveThemeToBox(bool isDarkMode)=>_b.write(_key, isDarkMode);
bool _loadThemeFromBox()=>_b.read(_key)??false;
ThemeMode get theme {
  return
  _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
}
void switchTheme(){
  Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.light:ThemeMode.dark);
  saveThemeToBox(!_loadThemeFromBox());
}

}