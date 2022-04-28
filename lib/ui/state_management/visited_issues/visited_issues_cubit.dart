import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/domain/logic/visited_issue_handler.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_state.dart';

class VisitedIssuesCubit extends Cubit<VisitedIssuesState> {
  VisitedIssuesCubit(this.visitedIssueHandler)
      : super(VisitedIssuesLoadingState());

  final VisitedIssueHandler visitedIssueHandler;

  Future<void> fetchVisitedIssues() async {
    await visitedIssueHandler.fetchVisitedIssues();
    emit(VisitedIssuesLoadedState(_isIssueVisited));
  }

  bool _isIssueVisited(Issue issue) =>
      visitedIssueHandler.isIssueVisited(issue);

  Future<void> markAsVisited(Issue issue) async {
    await visitedIssueHandler.markAsVisited(issue);
    emit(VisitedIssuesLoadedState(_isIssueVisited));
  }
}
