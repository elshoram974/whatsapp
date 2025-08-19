import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/app.dart';
import 'package:whatsapp/core/localization/localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: L10n.supported,
    path: L10n.path,
    fallbackLocale: L10n.fallback,
    useOnlyLangCode: true,
    child: const App(),
  ),);
}