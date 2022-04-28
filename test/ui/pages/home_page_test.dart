import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/logic/visited_issue_handler.dart';
import 'package:media_market_challenge/domain/models/fetch_issue_config.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issue_details.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/domain/repositories/visited_issues_repository.dart';
import 'package:media_market_challenge/ui/pages/home_page.dart';
import 'package:media_market_challenge/ui/state_management/github_issues/github_issues_cubit.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_cubit.dart';

import '../state_management/github_issues/issues_mock_data.dart';

class _MockGithubIssuesService implements IssuesRepository {
  @override
  Future<IssuesPageInfo> getIssues({required FetchIssuesConfig config}) {
    if (config.repoName != 'UnknownRepo') {
      return Future<IssuesPageInfo>.value(
        IssuesPageInfo(
          issues: jsonDecode(issuesMockData)
              .map<Issue>((dynamic e) => Issue.fromJson(e['node']))
              .toList(),
          hasPreviousPage: false,
        ),
      );
    }

    throw Exception('Repo not found!');
  }

  @override
  Future<IssueDetails> getIssue({
    required String repoName,
    required String repoOwner,
    required int number,
  }) {
    throw UnimplementedError();
  }
}

class _MockVisitedIssuesService implements VisitedIssuesRepository {
  @override
  Future<List<String>> fetchVisitedIssues() =>
      Future<List<String>>.value(<String>['I_kwDOAeUeuM5IJQZX']);

  @override
  Future<void> markAsVisited(Issue issue) {
    throw UnimplementedError();
  }
}

void main() {
  group('Home page', () {
    testWidgets('First shows loading indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        _TestWrapper(
          issuesCubit: GithubIssuesCubit(_MockGithubIssuesService()),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Load issues list', (WidgetTester tester) async {
      await tester.pumpWidget(
        _TestWrapper(
          issuesCubit: GithubIssuesCubit(_MockGithubIssuesService()),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.textContaining('Rename the test component'), findsOneWidget);
    });

    testWidgets('Shows error on facing exception', (WidgetTester tester) async {
      final GithubIssuesCubit issuesCubit =
          GithubIssuesCubit(_MockGithubIssuesService());

      await tester.pumpWidget(_TestWrapper(issuesCubit: issuesCubit));

      await issuesCubit.fetchIssues(
        config: const FetchIssuesConfig(repoName: 'UnknownRepo'),
      );

      await tester.pump();

      expect(find.textContaining('Repo not found'), findsOneWidget);
    });
  });
}

class _TestWrapper extends StatelessWidget {
  const _TestWrapper({Key? key, required this.issuesCubit}) : super(key: key);

  final GithubIssuesCubit issuesCubit;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<GithubIssuesCubit>(create: (_) => issuesCubit),
            BlocProvider<VisitedIssuesCubit>(
              create: (_) => VisitedIssuesCubit(
                VisitedIssueHandler(
                  _MockVisitedIssuesService(),
                ),
              )..fetchVisitedIssues(),
            ),
          ],
          child: const HomePage(),
        ),
      );
}
