import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/visited_issues_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String visitedIssuesKey = 'VISITED_ISSUES_KEY';

class SharedPrefVisitedIssuesService implements VisitedIssuesRepository {
  @override
  Future<List<String>> fetchVisitedIssues() async {
    return (await _getPreferences()).getStringList(visitedIssuesKey) ??
        <String>[];
  }

  @override
  Future<void> markAsVisited(Issue issue) async {
    final List<String> visitedIds = await fetchVisitedIssues();

    if (visitedIds.contains(issue.id)) {
      return;
    }

    await (await _getPreferences())
        .setStringList(visitedIssuesKey, visitedIds..add(issue.id));
  }

  Future<SharedPreferences> _getPreferences() async =>
      SharedPreferences.getInstance();
}
