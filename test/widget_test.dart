import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_code/src/presentation/qr_system_app.dart';

void main() {
  testWidgets('QR Studio starts on the generator tab', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: QrSystemApp()));

    expect(find.text('QR Studio'), findsWidgets);
    expect(find.text('Create'), findsOneWidget);
    expect(find.text('Scan'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
  });
}
