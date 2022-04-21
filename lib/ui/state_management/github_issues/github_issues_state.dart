part of 'github_issues_cubit.dart';

abstract class GithubIssuesState {}

class GithubIssuesLoadingState extends GithubIssuesState {}

class GithubIssuesLoadedState extends GithubIssuesState {
  GithubIssuesLoadedState(this.issues);

  final List<Issue> issues;
}

class GithubIssuesErrorState extends GithubIssuesState {
  GithubIssuesErrorState(this.message);

  final String message;
}
