import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

class MockGithubIssues implements IssuesRepository {
  @override
  Future<List<Issue>> getIssues({
    String repoName = 'mock_repo',
    String? repoOwner,
  }) {
    if (repoName == 'mock_repo') {
      return Future.value(
        <Issue>[],
      );
    }

    throw FlutterError('Repo not found!');
  }
}

void main() {
  group('GithubIssues cubit', () {});
}
