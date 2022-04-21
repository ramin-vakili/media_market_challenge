import 'package:media_market_challenge/domain/models/issue.dart';

/// Interface class for getting the list of issues.
abstract class IssuesRepository {
  /// Gets the list of github issues
  Future<List<Issue>> getIssues({
    String repoName,
    String repoOwner,
    int pageSize,
    String cursor,
  });
}
