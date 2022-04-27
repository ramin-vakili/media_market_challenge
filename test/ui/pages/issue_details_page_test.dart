import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issue_details.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/domain/repositories/visited_issues_repository.dart';
import 'package:media_market_challenge/ui/pages/issue_details_page.dart';
import 'package:media_market_challenge/ui/state_management/github_issue_details/github_issue_details_cubit.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_cubit.dart';
import 'package:media_market_challenge/ui/widgets/issue_state.dart';
import 'package:media_market_challenge/ui/widgets/user_avatar.dart';

import '../state_management/github_issues/issues_mock_data.dart';

void main() {
  group('Issue details page', () {
    testWidgets('IssueDetails page show issue details',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _TestWrapper(
          issue: Issue(
            id: '22433',
            title: 'Sample title, ',
            url: '',
            issueAuthor: const IssueAuthor(login: 'filmil', avatarUrl: ''),
            createdAt: DateTime.now(),
            number: 102266,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(IssueStateOpen), findsOneWidget);
      expect(find.text('This is body'), findsOneWidget);
      expect(find.byType(UserAvatar), findsOneWidget);
      expect(find.text('filmil'), findsOneWidget);
    });

    testWidgets('IssueDetails page show issue details',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _TestWrapper(
          issue: Issue(
            id: '0',
            title: 'Sample title, ',
            url: '',
            issueAuthor: const IssueAuthor(login: '', avatarUrl: ''),
            createdAt: DateTime.now(),
          ),
        ),
      );

      await tester.pump();

      expect(find.textContaining('not found'), findsOneWidget);
    });
  });
}

class _TestWrapper extends StatelessWidget {
  const _TestWrapper({Key? key, required this.issue}) : super(key: key);

  final Issue issue;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<GithubIssueDetailsCubit>(
                create: (_) =>
                    GithubIssueDetailsCubit(_MockGithubIssuesService())),
            BlocProvider<VisitedIssuesCubit>(
              create: (_) => VisitedIssuesCubit(_MockVisitedIssueService()),
            ),
          ],
          child: IssueDetailsPage(
            issue: issue,
            issuesRepository: _MockGithubIssuesService(),
          ),
        ),
      );
}

class _MockGithubIssuesService implements IssuesRepository {
  @override
  Future<IssuesPageInfo> getIssues({
    String repoName = 'mock_repo',
    String? repoOwner,
    int pageSize = 20,
    String? cursor,
    String orderBy = 'CREATED_AT',
    String direction = 'ASC',
    String? issueState,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<IssueDetails> getIssue({
    required String repoName,
    required String repoOwner,
    required int number,
  }) {
    if (number == 102266) {
      return Future<IssueDetails>.value(
        IssueDetails.fromJson(
          jsonDecode(issuesMockData).first['node'],
        ),
      );
    } else {
      throw Exception('Issue not found');
    }
  }
}

class _MockVisitedIssueService implements VisitedIssuesRepository {
  @override
  Future<List<String>> fetchVisitedIssues() {
    throw UnimplementedError();
  }

  @override
  Future<void> markAsVisited(Issue issue) => Future<void>.value();
}
