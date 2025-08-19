import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp/app.dart';
import 'package:whatsapp/core/localization/localization.dart';

void main() {
  testWidgets('RTL when Arabic', (tester) async {
    await EasyLocalization.ensureInitialized();
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: L10n.supported,
        path: L10n.path,
        fallbackLocale: L10n.fallback,
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      Directionality.of(tester.element(find.byType(MaterialApp))),
      TextDirection.LTR,
    );
  });
}
