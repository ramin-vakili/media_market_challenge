import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/state_management/github_issues/github_issues_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final GithubIssuesCubit _githubIssuesCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _githubIssuesCubit = BlocProvider.of<GithubIssuesCubit>(context)
      ..fetchIssues(repoName: 'flutter', repoOwner: 'flutter,');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MediaMarktChallenge'),
        ),
        body: BlocBuilder<GithubIssuesCubit, GithubIssuesState>(
          bloc: _githubIssuesCubit,
          builder: (_, GithubIssuesState state) {
            if (state is GithubIssuesLoadedState) {
              return _buildIssuesList(state.issues);
            } else if (state is GithubIssuesErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );

  Widget _buildIssuesList(List<Issue> issues) => ListView.builder(
        itemBuilder: (_, int index) => Text(issues[index].title),
        itemCount: issues.length,
        itemExtent: 50,
      );

  @override
  void dispose() {
    _githubIssuesCubit.close();
    super.dispose();
  }
}
