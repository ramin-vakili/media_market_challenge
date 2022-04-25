import 'package:media_market_challenge/domain/models/issue.dart';

abstract class VisitedIssuesRepository {
  /// Gets the list of visited issues' ids.
  Future<List<String>> fetchVisitedIssues();

  /// Adds an issue's id as visited.
  Future<void> markAsVisited(Issue issue);
}
