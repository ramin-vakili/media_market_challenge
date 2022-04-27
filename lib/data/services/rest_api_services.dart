import 'package:media_market_challenge/domain/models/fetch_issue_config.dart';
import 'package:media_market_challenge/domain/models/issue_details.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

class RestApiIssuesService implements IssuesRepository {
  @override
  Future<IssuesPageInfo> getIssues({required FetchIssuesConfig config}) {
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
