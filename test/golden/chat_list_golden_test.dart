import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main(){
  testGoldens('chat list renders', (tester) async {
    await loadAppFonts();
    final builder = GoldenBuilder.column()
      ..addScenario('light', const Placeholder())
      ..addScenario('dark', const Placeholder());
    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'chat_list');
  });
}