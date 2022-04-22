part of 'github_issue_details_cubit.dart';

abstract class GithubIssueDetailsState {}

class GithubIssueDetailsLoadingState extends GithubIssueDetailsState {}

class GithubIssueDetailsLoadedState extends GithubIssueDetailsState {
  GithubIssueDetailsLoadedState(this.issue);

  final Issue issue;
}

class GithubIssueDetailsErrorState extends GithubIssueDetailsState {
  GithubIssueDetailsErrorState(this.message);

  final String message;
}
