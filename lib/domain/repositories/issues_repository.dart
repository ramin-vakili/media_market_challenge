import 'package:media_market_challenge/domain/models/issues_page_info.dart';

/// Interface class for getting the list of issues.
abstract class IssuesRepository {
  /// Gets the list of github issues
  Future<IssuesPageInfo> getIssues({
    String repoName,
    String repoOwner,
    int pageSize,
    String? cursor,
  });
}
