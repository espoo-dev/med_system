import 'package:distrito_medico/core/pages/success/success.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';

void main() {
  testWidgets('SuccessPage UI Test', (WidgetTester tester) async {
    String title = 'Success Title';
    final Widget goToPage = Container();

    await tester.pumpWidget(
      MaterialApp(
        home: SuccessPage(
          title: title,
          goToPage: goToPage,
        ),
      ),
    );

    expect(find.text(title), findsOneWidget);

    expect(find.byType(Lottie), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));

    expect(find.byWidget(goToPage), findsOneWidget);
  });
}
