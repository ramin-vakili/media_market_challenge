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

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.extentAfter < 500) {
          _githubIssuesCubit.loadMore();
        }
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _githubIssuesCubit = BlocProvider.of<GithubIssuesCubit>(context)
      ..fetchIssues();
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
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );

  Widget _buildIssuesList(List<Issue> issues) => ListView.builder(
        itemBuilder: (_, int index) {
          if (index == issues.length) {
            return const SizedBox(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return Text(issues[index].title);
        },
        itemCount: issues.length + 1,
        itemExtent: 50,
      );

  @override
  void dispose() {
    _githubIssuesCubit.close();
    super.dispose();
  }
}
