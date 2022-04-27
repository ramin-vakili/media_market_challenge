import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/domain/models/enums.dart';
import 'package:media_market_challenge/domain/models/fetch_issue_config.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

part 'github_issues_state.dart';

class GithubIssuesCubit extends Cubit<GithubIssuesState> {
  GithubIssuesCubit(this.issuesRepository) : super(GithubIssuesLoadingState());

  final IssuesRepository issuesRepository;

  FetchIssuesConfig _config = const FetchIssuesConfig();

  FetchIssuesConfig get currentConfig => _config;

  Future<void> updateOrder({
    IssueOrderField orderBy = IssueOrderField.createdAt,
    OrderDirection direction = OrderDirection.asc,
  }) async {
    _config = _config.copyWith(orderBy: orderBy, direction: direction);

    emit(GithubIssuesLoadingState());
    await fetchIssues(config: _config);
  }

  Future<void> fetchIssues({
    required FetchIssuesConfig config,
    bool refresh = true,
  }) async {
    try {
      _config = config;

      final IssuesPageInfo issuesPageInfo =
          await issuesRepository.getIssues(config: config);

      _prepareLoadedState(issuesPageInfo, refresh);
    } on Exception catch (e) {
      emit(GithubIssuesErrorState(e.toString()));
    }
  }

  void _prepareLoadedState(IssuesPageInfo issuesPageInfo, bool refresh) {
    late IssuesPageInfo resultPageInfo;

    final GithubIssuesState currentState = state;

    if (!refresh && currentState is GithubIssuesLoadedState) {
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

  Future<void> loadMore() async {
    final GithubIssuesState currentState = state;

    if (currentState is GithubIssuesLoadedState) {
      await fetchIssues(
        refresh: false,
        config: _config.copyWith(cursor: currentState.issuesPageInfo.cursor),
      );
    }
  }
}
