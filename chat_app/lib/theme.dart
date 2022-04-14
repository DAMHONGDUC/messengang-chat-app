import 'package:chat_app/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This is our  main focus
// Let's apply light and dark theme on our app
// Now let's add dark theme on our app

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: AppColor.kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme,
    iconTheme: IconThemeData(color: AppColor.kContentColorLightTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: AppColor.kContentColorLightTheme),
    colorScheme: ColorScheme.light(
      primary: AppColor.kPrimaryColor,
      secondary: AppColor.kSecondaryColor,
      error: AppColor.kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColor.kContentColorLightTheme.withOpacity(0.7),
      unselectedItemColor: AppColor.kContentColorLightTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: AppColor.kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    primaryColor: AppColor.kPrimaryColor,
    scaffoldBackgroundColor: AppColor.kContentColorLightTheme,
    appBarTheme: appBarTheme,
    iconTheme: IconThemeData(color: AppColor.kContentColorDarkTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: AppColor.kContentColorDarkTheme),
    colorScheme: ColorScheme.dark().copyWith(
      primary: AppColor.kPrimaryColor,
      secondary: AppColor.kSecondaryColor,
      error: AppColor.kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.kContentColorLightTheme,
      selectedItemColor: Colors.white70,
      unselectedItemColor: AppColor.kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: AppColor.kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

final appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
