import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

class RestApiIssuesService implements IssuesRepository {
  @override
  Future<List<Issue>> getIssues({
    String? repoName,
    String? repoOwner,
    int pageSize = 20,
    String? cursor,
  }) {
    // TODO(Ramin): Get data from REST API.
    throw UnimplementedError();
  }
}
