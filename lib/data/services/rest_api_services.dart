import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

class RestApiIssuesService implements IssuesRepository {
  @override
  Future<IssuesPageInfo> getIssues({
    required String repoName,
    required String repoOwner,
    int pageSize = 20,
    String? cursor,
  }) {
    // TODO(Ramin): Get data from REST API.
    throw UnimplementedError();
  }

  @override
  Future<Issue> getIssue({
    required String repoName,
    required String repoOwner,
    required int number,
  }) {
    // TODO(Ramin): Get data from REST API.
    throw UnimplementedError();
  }
}
