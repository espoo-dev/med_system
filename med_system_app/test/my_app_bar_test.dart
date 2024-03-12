import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyAppBar widget test', (WidgetTester tester) async {
    // Build MyAppBar widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: MyAppBar(
            title: 'Test Title',
            hideLeading: false,
            image: null,
            onPressed: () {},
          ),
        ),
      ),
    );

    final titleFinder = find.text('Test Title');
    final leadingIconFinder = find.byIcon(Icons.arrow_back_ios_new);

    expect(titleFinder, findsOneWidget);
    expect(leadingIconFinder, findsOneWidget);

    await tester.tap(leadingIconFinder);
    await tester.pumpAndSettle();
  });
}
