import 'package:media_market_challenge/domain/models/issue_details.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

class RestApiIssuesService implements IssuesRepository {
  @override
  Future<IssuesPageInfo> getIssues({
    required String repoName,
    required String repoOwner,
    int pageSize = 20,
    String? cursor,
    String orderBy = 'CREATED_AT',
    String direction = 'ASC',
    List<String> issueState = const <String>['OPEN', 'CLOSED'],
  }) {
    // TODO(Ramin): Get data from REST API.
    throw UnimplementedError();
  }

  @override
  Future<IssueDetails> getIssue({
    required String repoName,
    required String repoOwner,
    required int number,
  }) {
    // TODO(Ramin): Get data from REST API.
    throw UnimplementedError();
  }
}
