import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/widgets/issue_item.dart';
import 'package:media_market_challenge/ui/widgets/user_avatar.dart';

void main() {
  testWidgets('IssueItem shows correct information',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: IssueItem(
            issue: Issue(
              id: '12',
              createdAt: DateTime.utc(2000, 10, 1, 1),
              issueAuthor: const IssueAuthor(
                avatarUrl: 'https://mock.url',
                login: 'loginId',
              ),
              url: 'https://mock.url',
              title: 'title',
            ),
            isVisited: true,
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(UserAvatar), findsOneWidget);
    expect(find.byIcon(Icons.remove_red_eye), findsOneWidget);
    expect(find.textContaining('title'), findsOneWidget);
  });
}
