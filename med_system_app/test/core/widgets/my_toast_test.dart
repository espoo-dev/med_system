import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomToast shows correct toast widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                CustomToast.show(
                  context,
                  type: ToastType.success,
                  title: 'Success',
                  description: 'Operation successful!',
                );
              },
              child: const Text('Show Toast'),
            );
          },
        ),
      ),
    ));

    // Press the button to trigger showing the toast
    await tester.tap(find.text('Show Toast'));
    await tester.pumpAndSettle();

    // Find the toast widget
    expect(find.byType(CustomToastWidget), findsOneWidget);

    // Check if the title and description match what was provided
    expect(find.text('Success'), findsOneWidget);
    expect(find.text('Operation successful!'), findsOneWidget);
  });
}
