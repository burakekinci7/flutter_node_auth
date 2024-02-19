import 'package:flutter/material.dart';
import 'package:flutter_node_auth/core/services/auth_services.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            // Now you can use the obtained context
            AuthService authService = AuthService();

            // Make sure to replace 'email' and 'password' with actual values
            authService.signUpUser(
                context: context, email: 'test@test.com', password: '123456',name: 'test');

            // Perform any other test actions

            return Container(); // Return a widget for testing purposes
          },
        ),
      ),
    );
/*     // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget); */
  });
}
