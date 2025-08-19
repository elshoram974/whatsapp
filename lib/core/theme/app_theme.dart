import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants/colors.dart';

ThemeData lightTheme() {
  final base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(primary: AppColors.whatsappGreen),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.whatsappGreen, foregroundColor: Colors.white),
    listTileTheme: const ListTileThemeData(iconColor: Colors.black87),
    scaffoldBackgroundColor: Colors.white,
  );
}

ThemeData darkTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(primary: AppColors.whatsappGreen),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.whatsappGreen, foregroundColor: Colors.white),
    scaffoldBackgroundColor: const Color(0xFF121B22),
    listTileTheme: const ListTileThemeData(iconColor: Colors.white70),
  );
}