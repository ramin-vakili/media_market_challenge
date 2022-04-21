import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/ui/state_management/github_issues/github_issues_cubit.dart';

import 'issues_mock_data.dart';

class MockGithubIssuesService implements IssuesRepository {
  @override
  Future<List<Issue>> getIssues({
    String repoName = 'mock_repo',
    String? repoOwner,
  }) {
    if (repoName == 'mock_repo') {
      return Future.value(
        jsonDecode(issuesMockData)
            .map<Issue>((dynamic e) => Issue.fromJson(e['node']))
            .toList(),
      );
    }

    throw FlutterError('Repo not found!');
  }
}

void main() {
  late GithubIssuesCubit _githubIssuesCubit;

  setUpAll(() {
    _githubIssuesCubit = GithubIssuesCubit(MockGithubIssuesService());
  });

  tearDownAll(() {
    _githubIssuesCubit.close();
  });

  group('GithubIssues cubit', () {
    test('emit loaded states if gets the issues', () async {
      await _githubIssuesCubit.fetchIssues(
        repoName: 'mock_repo',
        repoOwner: 'mock_owner',
      );

      expect(_githubIssuesCubit.state, isA<GithubIssuesLoadedState>());
    });
  });
}
