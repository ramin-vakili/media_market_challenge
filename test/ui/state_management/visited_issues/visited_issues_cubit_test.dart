import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/logic/visited_issue_handler.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/visited_issues_repository.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_cubit.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_state.dart';

void main() {
  group('VisitedIssuesCubit', () {
    test('is in loading state initially', () {
      final VisitedIssuesCubit visitedIssuesCubit =
          VisitedIssuesCubit(VisitedIssueHandler(_MockVisitedIssuesService()));

      expect(visitedIssuesCubit.state, isA<VisitedIssuesLoadingState>());
    });

    test('is in loaded state after fetching data', () async {
      final VisitedIssuesCubit visitedIssuesCubit =
          VisitedIssuesCubit(VisitedIssueHandler(_MockVisitedIssuesService()));

      await visitedIssuesCubit.fetchVisitedIssues();

      expect(visitedIssuesCubit.state, isA<VisitedIssuesLoadedState>());

      final VisitedIssuesLoadedState loadedState =
          visitedIssuesCubit.state as VisitedIssuesLoadedState;

      final Issue issue = Issue(
        id: 'I_kwDOAeUeuM5IJQZX',
        createdAt: DateTime.utc(2000),
        title: '',
        issueAuthor: const IssueAuthor(avatarUrl: '', login: ''),
        url: '',
      );

      expect(loadedState.isIssueVisited(issue), isTrue);
    });
  });
}

class _MockVisitedIssuesService implements VisitedIssuesRepository {
  @override
  Future<List<String>> fetchVisitedIssues() =>
      Future<List<String>>.value(<String>['I_kwDOAeUeuM5IJQZX']);

  @override
  Future<void> markAsVisited(Issue issue) {
    throw UnimplementedError();
  }
}
