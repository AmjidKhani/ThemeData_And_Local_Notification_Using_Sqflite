import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Color bluishClr=const Color(0xFF4e5ae8);
Color yellowClr=const Color(0xFFFF8746);
Color pinkClr=const Color(0xFFff4667);
Color white=Colors.white;
Color primaryClr=bluishClr;
Color darkGreyClr=const Color(0xFF121212);
Color darkHeaderClr=const Color(0xFF424242);
class Themes {
  static final lightmode=
   ThemeData(
     backgroundColor: Colors.white,
  primarySwatch: Colors.blue,
  brightness: Brightness.light,

   );
  static final darkmode=
  ThemeData(
    backgroundColor: darkGreyClr,
    primaryColor:darkGreyClr,
  //primaryColor: darkGreyClr,
  brightness: Brightness.dark
  );
}
TextStyle get titlestyle
{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontWeight: FontWeight.bold,fontSize: 18,
          color: Get.isDarkMode?Colors.grey[400]:Colors.black
      )
  );
}
TextStyle get subHeadingstyle
{
  return GoogleFonts.lato(
  textStyle: TextStyle(
    fontWeight: FontWeight.bold,fontSize: 24,
    color: Get.isDarkMode?Colors.grey[400]:Colors.grey
  )
  );
}
TextStyle get Headingstyle
{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontWeight: FontWeight.bold,fontSize: 30
      )
  );
}
//used in HintText
TextStyle get subTitleStyle
{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Get.isDarkMode?Colors.grey[100]:Colors.grey[400]
      )
  );
}