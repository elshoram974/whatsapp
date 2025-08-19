import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('menu_settings'.tr())),
      body: ListView(children: [
        ListTile(title: Text('settings_language'.tr()), subtitle: Text('settings_language_note'.tr())),
        RadioListTile<Locale>(
          value: const Locale('en'), groupValue: context.locale, title: Text('language_en'.tr()), onChanged: (l){ if(l!=null) context.setLocale(l); },
        ),
        RadioListTile<Locale>(
          value: const Locale('ar'), groupValue: context.locale, title: Text('language_ar'.tr()), onChanged: (l){ if(l!=null) context.setLocale(l); },
        ),
      ],),
    );
  }
}