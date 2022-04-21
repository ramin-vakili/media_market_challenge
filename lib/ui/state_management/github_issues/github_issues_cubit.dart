import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

part 'github_issues_state.dart';

class GithubIssuesCubit extends Cubit<GithubIssuesState> {
  GithubIssuesCubit(this.issuesRepository) : super(GithubIssuesLoadingState());

  final IssuesRepository issuesRepository;

  Future<void> fetchIssues({
    required String repoName,
    required String repoOwner,
  }) async {
    try {
      final List<Issue> issues = await issuesRepository.getIssues(
        repoName: repoName,
        repoOwner: repoOwner,
      );

      emit(GithubIssuesLoadedState(issues));
    } on Exception catch (e) {
      emit(GithubIssuesErrorState(e.toString()));
    }
  }
}
