import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:theamdata/Db/DBHelper.dart';
import 'package:theamdata/Provide/ThemeService.dart';
import 'package:theamdata/homepage.dart';
import 'package:theamdata/ui/Themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
 ThemeService abc=  new ThemeService();
   MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
theme: Themes.lightmode,
        darkTheme: Themes.darkmode,
        themeMode: ThemeService().theme,
        home: homepage()
    );
  }
}


