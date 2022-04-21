import 'package:flutter_bloc/flutter_bloc.dart';

part 'github_issues_state.dart';

class GithubIssuesCubit extends Cubit<GithubIssuesState> {
  GithubIssuesCubit() : super(GithubIssuesLoadingState());

  void connectToGraphQL(String url, String token) async {}
}
