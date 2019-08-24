
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_messenger/main.dart';
import 'package:flutter_messenger/pages/RegisterPage.dart';

void main() {
  testWidgets('Main UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Messenger());

    expect(find.byType(RegisterPage),findsOneWidget);

  });
}
