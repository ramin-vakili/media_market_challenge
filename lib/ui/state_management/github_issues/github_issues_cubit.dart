import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

part 'github_issues_state.dart';

class GithubIssuesCubit extends Cubit<GithubIssuesState> {
  GithubIssuesCubit(this.issuesRepository) : super(GithubIssuesLoadingState());

  final IssuesRepository issuesRepository;

  FetchIssuesConfig? _config;

  Future<void> updateOrder({
    String orderBy = 'CREATED_AT',
    String direction = 'ASC',
  }) async {
    if (_config != null) {
      _config = _config!.copyWith(orderBy: orderBy, direction: direction);

      emit(GithubIssuesLoadingState());
      await fetchIssues(config: _config!);
    }
  }

  Future<void> fetchIssues({
    required FetchIssuesConfig config,
    String? cursor,
    bool refresh = true,
  }) async {
    try {
      _config = config;

      final IssuesPageInfo issuesPageInfo = await issuesRepository.getIssues(
        repoName: config.repoName,
        repoOwner: config.repoOwner,
        pageSize: config.pageSize,
        cursor: cursor,
        orderBy: config.orderBy,
        direction: config.direction,
      );

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

    if (currentState is GithubIssuesLoadedState && _config != null) {
      await fetchIssues(
        cursor: currentState.issuesPageInfo.cursor,
        refresh: false,
        config: _config!,
      );
    }
  }
}

@immutable
class FetchIssuesConfig {
  const FetchIssuesConfig({
    this.orderBy = 'CREATED_AT',
    this.direction = 'ASC',
    this.pageSize = 20,
    this.repoName = 'flutter',
    this.repoOwner = 'flutter',
  });

  final String orderBy;
  final String direction;
  final int pageSize;
  final String repoName;
  final String repoOwner;

  FetchIssuesConfig copyWith({
    String? orderBy,
    String? direction,
    int? pageSize,
    String? repoName,
    String? repoOwner,
  }) =>
      FetchIssuesConfig(
        orderBy: orderBy ?? this.orderBy,
        direction: direction ?? this.direction,
        pageSize: pageSize ?? this.pageSize,
        repoName: repoName ?? this.repoName,
        repoOwner: repoOwner ?? this.repoOwner,
      );
}
