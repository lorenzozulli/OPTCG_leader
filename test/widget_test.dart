// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';

import 'package:optcgcounter_flutter/main.dart';

void main() {
  final Leader defaultLeader = Leader(
    name: 'Kozuki Oden', // Provide a default name
    id: 'EB01-001',       // Provide a default ID
    images: Images(imageEn: 'https://en.onepiece-cardgame.com/images/cardlist/card/EB01-001.png?250701', imagesAlt: []), // Provide default images
    life: '4',           // Provide default life
    power: '5000',          // Provide default power
    colors: ['green','red'],
    effect: ''
  );
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(leader: defaultLeader, imageString: defaultLeader.images.imageEn));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
