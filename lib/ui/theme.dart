import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


class Themes{ //тут будут находиться темы
  static final light = ThemeData( //тема (цвета кнопок, фона, текста)
      backgroundColor: Colors.white,
      primaryColor: Colors.pink,
      brightness: Brightness.light //яркость, задает светлый или темный фон текста
  );

}

TextStyle get subHeadingStyle {
  return TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color:  Colors.white
  );
}

TextStyle get headingStyle{
  return  TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black

  );
}

TextStyle get titleStyle{
  return TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black

  );
}

TextStyle get subTitleStyle {
  return TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.grey[600]

  );
}
  TextStyle get App_TitleStyle{
    return TextStyle(
            fontSize: 26,
          fontWeight: FontWeight.bold,
            color: Colors.white,
    );
}