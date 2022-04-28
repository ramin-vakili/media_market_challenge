import 'package:media_market_challenge/domain/models/issue.dart';

abstract class VisitedIssuesState {}

class VisitedIssuesLoadingState extends VisitedIssuesState {}

class VisitedIssuesLoadedState extends VisitedIssuesState {
  VisitedIssuesLoadedState(this.isIssueVisited);

  final bool Function(Issue) isIssueVisited;
}
