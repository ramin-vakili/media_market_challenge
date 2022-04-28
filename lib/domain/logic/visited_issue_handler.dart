import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/visited_issues_repository.dart';

class VisitedIssueHandler {
  VisitedIssueHandler(this.visitedIssuesRepository);

  final VisitedIssuesRepository visitedIssuesRepository;

  final List<String> _visitedIssues = <String>[];

  List<String> get visitedIssues => _visitedIssues;

  Future<List<String>> fetchVisitedIssues() async {
    _visitedIssues
      ..clear()
      ..addAll(await visitedIssuesRepository.fetchVisitedIssues());

    return _visitedIssues;
  }

  bool isIssueVisited(Issue issue) => _issueIsVisited(issue);

  Future<void> markAsVisited(Issue issue) async {
    if (_issueIsVisited(issue)) {
      return;
    }

    _visitedIssues.add(issue.id);
    await visitedIssuesRepository.markAsVisited(issue);
  }

  bool _issueIsVisited(Issue issue) => _visitedIssues.contains(issue.id);
}
