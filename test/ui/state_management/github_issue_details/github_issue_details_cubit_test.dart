import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issue_details.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/ui/state_management/github_issue_details/github_issue_details_cubit.dart';

import '../github_issues/issues_mock_data.dart';

void main() {
  group('GithubIssueDetailsCubit', () {
    test('is initial state before loaded data', () {
      final GithubIssueDetailsCubit githubIssueDetailsCubit =
          GithubIssueDetailsCubit(_MockGithubIssuesService());

      expect(
        githubIssueDetailsCubit.state,
        isA<GithubIssueDetailsLoadingState>(),
      );
    });

    test('is loading and then loaded state with the proper loaded data',
        () async {
      final GithubIssueDetailsCubit githubIssueDetailsCubit =
          GithubIssueDetailsCubit(_MockGithubIssuesService());
      await githubIssueDetailsCubit.fetchIssue(number: 102266);

      expect(
        githubIssueDetailsCubit.state,
        isA<GithubIssueDetailsLoadedState>(),
      );

      final GithubIssueDetailsLoadedState loadedState =
          githubIssueDetailsCubit.state as GithubIssueDetailsLoadedState;

      expect(loadedState.issueDetails.id, 'I_kwDOAeUeuM5IJQZX');
      expect(loadedState.issueDetails.state, IssueState.open);
      expect(loadedState.issueDetails.body, 'This is body');
      expect(
        loadedState.issueDetails.title,
        contains('Rename the test component'),
      );
    });

    test('emit error state if fetching issue details fails', () async {
      final GithubIssueDetailsCubit githubIssueDetailsCubit =
          GithubIssueDetailsCubit(_MockGithubIssuesService());
      await githubIssueDetailsCubit.fetchIssue(number: 0);

      expect(
        githubIssueDetailsCubit.state,
        isA<GithubIssueDetailsErrorState>(),
      );

      expect(
        (githubIssueDetailsCubit.state as GithubIssueDetailsErrorState).message,
        contains('Issue not found'),
      );
    });
  });
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
    List<String>? issueState,
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
