import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issue_details.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/ui/state_management/github_issues/github_issues_cubit.dart';

import 'issues_mock_data.dart';

class _MockGithubIssuesService implements IssuesRepository {
  @override
  Future<IssuesPageInfo> getIssues({
    String repoName = 'mock_repo',
    String? repoOwner,
    int pageSize = 20,
    String? cursor,
    String orderBy = 'CREATED_AT',
    String direction = 'ASC',
  }) {
    if (repoName == 'mock_repo') {
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

void main() {
  late GithubIssuesCubit _githubIssuesCubit;

  setUpAll(() {
    _githubIssuesCubit = GithubIssuesCubit(_MockGithubIssuesService());
  });

  tearDownAll(() {
    _githubIssuesCubit.close();
  });

  group('GithubIssues cubit', () {
    test('state is Loading state initially', () {
      expect(_githubIssuesCubit.state, isA<GithubIssuesLoadingState>());
    });

    test('emit loaded states if gets the issues', () async {
      await _githubIssuesCubit.fetchIssues(
        config: const FetchIssuesConfig(
          repoName: 'mock_repo',
          repoOwner: 'mock_owner',
        ),
      );

      expect(_githubIssuesCubit.state, isA<GithubIssuesLoadedState>());

      final List<Issue> issues =
          (_githubIssuesCubit.state as GithubIssuesLoadedState)
              .issuesPageInfo
              .issues;
      expect(issues.length, 2);

      final Issue firstIssue = issues.first;
      expect(firstIssue.id, 'I_kwDOAeUeuM5IJQZX');
      expect(firstIssue.number, 102266);
      expect(firstIssue.state, IssueState.open);
      expect(
        firstIssue.url,
        'https://github.com/flutter/flutter/issues/102266',
      );
      expect(firstIssue.issueAuthor.login, 'filmil');
      expect(
        firstIssue.issueAuthor.avatarUrl,
        'https://avatars.githubusercontent.com/u/246576?v=4',
      );
    });

    test('emits error state if fetching issues is unsuccessful', () async {
      await _githubIssuesCubit.fetchIssues(
        config: const FetchIssuesConfig(
          repoName: 'UnknownRepo',
          repoOwner: 'Unknown',
        ),
      );

      expect(_githubIssuesCubit.state, isA<GithubIssuesErrorState>());
      expect(
        (_githubIssuesCubit.state as GithubIssuesErrorState).message,
        contains('Repo not found!'),
      );
    });
  });
}
