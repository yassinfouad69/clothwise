import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clothwise/src/app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: ClothWiseApp(),
      ),
    );

    // Verify that splash screen loads
    expect(find.text('ClothWise'), findsOneWidget);
    expect(find.text('AI outfits, styled for the weather.'), findsOneWidget);
  });
}
