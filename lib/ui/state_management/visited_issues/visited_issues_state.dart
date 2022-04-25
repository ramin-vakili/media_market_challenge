abstract class VisitedIssuesState {}

class VisitedIssuesLoadingState extends VisitedIssuesState {}

class VisitedIssuesLoadedState extends VisitedIssuesState {
  VisitedIssuesLoadedState(this.ids);

  final List<String> ids;
}
