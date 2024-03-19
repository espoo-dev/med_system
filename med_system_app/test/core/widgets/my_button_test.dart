import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyButtonWidget UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyButtonWidget(
            text: 'Pressione-me',
            onTap: () {},
            isLoading: false,
            height: 50,
            width: 200,
            backgroundColor: Colors.blue,
            disabledColor: Colors.grey,
            textColor: Colors.white,
          ),
        ),
      ),
    );

    expect(find.text('Pressione-me'), findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('MyButtonWidget Loading Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyButtonWidget(
            text: 'Pressione-me',
            onTap: () {},
            isLoading: true,
            height: 50,
            width: 200,
            backgroundColor: Colors.blue,
            disabledColor: Colors.grey,
            textColor: Colors.white,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
