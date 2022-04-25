import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/data/services/visited_issues_services.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_state.dart';

class VisitedIssuesCubit extends Cubit<VisitedIssuesState> {
  VisitedIssuesCubit(this.visitedIssuesService)
      : super(VisitedIssuesLoadingState());

  final VisitedIssuesService visitedIssuesService;

  final List<String> _visitedIssues = <String>[];

  Future<void> fetchVisitedIssues() async {
    _visitedIssues
      ..clear()
      ..addAll(await visitedIssuesService.fetchVisitedIssues());

    emit(VisitedIssuesLoadedState(_visitedIssues));
  }

  Future<void> markAsVisited(Issue issue) async {
    if (!_visitedIssues.contains(issue.id)) {
      _visitedIssues.add(issue.id);
    }

    await visitedIssuesService.markAsVisited(issue);

    emit(VisitedIssuesLoadedState(_visitedIssues));
  }
}
