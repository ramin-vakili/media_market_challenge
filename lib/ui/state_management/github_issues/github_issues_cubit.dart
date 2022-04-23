import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

part 'github_issues_state.dart';

class GithubIssuesCubit extends Cubit<GithubIssuesState> {
  GithubIssuesCubit(this.issuesRepository) : super(GithubIssuesLoadingState());

  final IssuesRepository issuesRepository;

  Future<void> fetchIssues({
    String repoName = 'flutter',
    String repoOwner = 'flutter',
    int pageSize = 20,
    String? cursor,
    String orderBy = 'CREATED_AT',
    String direction = 'ASC',
  }) async {
    try {
      final IssuesPageInfo issuesPageInfo = await issuesRepository.getIssues(
        repoName: repoName,
        repoOwner: repoOwner,
        pageSize: pageSize,
        cursor: (cursor == null && state is GithubIssuesLoadedState)
            ? (state as GithubIssuesLoadedState).issuesPageInfo.cursor
            : cursor,
        orderBy: orderBy,
        direction: direction,
      );

      _handleLoadMore(issuesPageInfo);
    } on Exception catch (e) {
      emit(GithubIssuesErrorState(e.toString()));
    }
  }

  void _handleLoadMore(IssuesPageInfo issuesPageInfo) {
    late IssuesPageInfo resultPageInfo;

    final GithubIssuesState currentState = state;

    if (currentState is GithubIssuesLoadedState) {
      resultPageInfo = IssuesPageInfo(
        issues: <Issue>[
          ...currentState.issuesPageInfo.issues,
          ...issuesPageInfo.issues
        ],
        hasPreviousPage: issuesPageInfo.hasPreviousPage,
        cursor: issuesPageInfo.cursor,
      );
    } else {
      resultPageInfo = issuesPageInfo;
    }

    emit(GithubIssuesLoadedState(resultPageInfo));
  }

  Future<void> loadMore() => fetchIssues();
}
