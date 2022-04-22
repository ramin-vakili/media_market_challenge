import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

part 'github_issue_details_state.dart';

class GithubIssueDetailsCubit extends Cubit<GithubIssueDetailsState> {
  GithubIssueDetailsCubit(this.issuesRepository)
      : super(GithubIssueDetailsLoadingState());

  final IssuesRepository issuesRepository;

  Future<void> fetchIssue({
    String repoName = 'flutter',
    String repoOwner = 'flutter',
    required int number,
  }) async {
    try {
      final Issue issue = await issuesRepository.getIssue(
        repoName: repoName,
        repoOwner: repoOwner,
        number: number,
      );

      emit(GithubIssueDetailsLoadedState(issue));
    } on Exception catch (e) {
      emit(GithubIssueDetailsErrorState(e.toString()));
    }
  }
}
