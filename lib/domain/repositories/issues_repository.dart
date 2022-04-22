import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issue_details.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';

/// Interface class for getting the list of issues.
abstract class IssuesRepository {
  /// Gets the list of github issues
  Future<IssuesPageInfo> getIssues({
    required String repoName,
    required String repoOwner,
    int pageSize,
    String? cursor,
  });

  /// Gets an issue.
  Future<IssueDetails> getIssue({
    required String repoName,
    required String repoOwner,
    required int number,
  });
}
