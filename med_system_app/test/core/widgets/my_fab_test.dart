import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('buildExtendedFAB creates a FloatingActionButton with text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return buildExtendedFAB(context, 'Test Button', () {});
          },
        ),
      ),
    ));

    final floatingActionButtonFinder = find.byType(FloatingActionButton);

    expect(floatingActionButtonFinder, findsOneWidget);

    final textFinder = find.text('Test Button');

    expect(textFinder, findsOneWidget);
  });
}
