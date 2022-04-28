import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/logic/visited_issue_handler.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/visited_issues_repository.dart';

void main() {
  group('VisitedIssuesHandler', () {
    test('VisitedIssuesHandler give us the correct ids', () async {
      final VisitedIssueHandler visitedIssueHandler =
          VisitedIssueHandler(_MockVisitedIssuesService());
      await visitedIssueHandler.fetchVisitedIssues();

      expect(visitedIssueHandler.visitedIssues.length, 1);
    });

    test('visiting an issue, adds it in the visited issues list', () async {
      final VisitedIssueHandler visitedIssueHandler =
          VisitedIssueHandler(_MockVisitedIssuesService());
      await visitedIssueHandler.fetchVisitedIssues();

      final Issue issue = Issue(
        id: 'id2',
        title: 'title',
        url: 'url',
        createdAt: DateTime(2000),
        issueAuthor: const IssueAuthor(login: '', avatarUrl: ''),
      );

      await visitedIssueHandler.markAsVisited(issue);

      expect(visitedIssueHandler.visitedIssues.length, 2);
      expect(visitedIssueHandler.isIssueVisited(issue), isTrue);
    });

    test('if visiting an issue again, it will not add it to visited ones',
        () async {
      final VisitedIssueHandler visitedIssueHandler =
          VisitedIssueHandler(_MockVisitedIssuesService());
      await visitedIssueHandler.fetchVisitedIssues();

      final Issue issue = Issue(
        id: 'id2',
        title: 'title',
        url: 'url',
        createdAt: DateTime(2000),
        issueAuthor: const IssueAuthor(login: '', avatarUrl: ''),
      );

      await visitedIssueHandler.markAsVisited(issue);

      expect(visitedIssueHandler.visitedIssues.length, 2);
      expect(visitedIssueHandler.isIssueVisited(issue), isTrue);

      await visitedIssueHandler.markAsVisited(issue);
      expect(visitedIssueHandler.visitedIssues.length, 2);
      expect(visitedIssueHandler.isIssueVisited(issue), isTrue);
    });
  });
}

class _MockVisitedIssuesService implements VisitedIssuesRepository {
  final List<String> visitedIssue = <String>['id1'];

  @override
  Future<List<String>> fetchVisitedIssues() async => visitedIssue;

  @override
  Future<void> markAsVisited(Issue issue) async => visitedIssue.add(issue.id);
}
