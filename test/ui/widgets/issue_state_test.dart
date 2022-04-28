import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/ui/widgets/issue_state.dart';

void main() {
  BoxDecoration findIssueStateDecoration(WidgetTester tester) =>
      (tester.firstWidget(
                  find.byKey(const ValueKey<String>('issue-state-icon-key')))
              as Container)
          .decoration as BoxDecoration;

  testWidgets('IssueStateOpen widget gets shown correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: IssueStateOpen(),
      ),
    ));

    await tester.pump();

    expect(find.byIcon(Icons.adjust_outlined), findsOneWidget);
    expect(find.text('Open'), findsOneWidget);
    expect(findIssueStateDecoration(tester).color, const Color(0xff21a954));
  });

  testWidgets('IssueStateClosed widget gets shown correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: IssueStateClosed(),
      ),
    ));

    await tester.pump();

    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    expect(find.text('Closed'), findsOneWidget);
    expect(findIssueStateDecoration(tester).color, const Color(0xff7e4ed5));
  });
}
