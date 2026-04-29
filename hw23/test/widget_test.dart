import 'dart:io';

import 'package:hive/hive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:hw23/main.dart';

void main() {
  setUpAll(() async {
    final tempDir = await Directory.systemTemp.createTemp('hw23_test_');
    Hive.init(tempDir.path);
  });

  testWidgets('App shows habits screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump();

    expect(find.text('Habits'), findsOneWidget);
  });
}
