import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/domain/enums.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/state_management/github_issues/github_issues_cubit.dart';
import 'package:media_market_challenge/ui/widgets/issue_item.dart';
import 'package:media_market_challenge/ui/widgets/single_choose_option.dart';
import 'package:media_market_challenge/ui/extensions/enum_extensions.dart';

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
        if (_scrollController.position.extentAfter < 5) {
          _githubIssuesCubit.loadMore();
        }
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _githubIssuesCubit = BlocProvider.of<GithubIssuesCubit>(context)
      ..fetchIssues(config: const FetchIssuesConfig());
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
              return _buildIssuesList(state.issuesPageInfo.issues);
            } else if (state is GithubIssuesErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );

  Widget _buildIssuesList(List<Issue> issues) => Column(
        children: <Widget>[
          SingleChooseOption<IssueOrderField>(
            options: IssueOrderField.values,
            onOptionSelected: (IssueOrderField field) async {
              print('Fetching with $field order');
              await _githubIssuesCubit.updateOrder(
                orderBy: field.snakeCaseName,
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (_, int index) {
                late Widget item;

                if (index == issues.length) {
                  item = const Center(child: CircularProgressIndicator());
                } else {
                  item = IssueItem(issue: issues[index]);
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: item,
                );
              },
              itemCount: issues.length + 1,
              itemExtent: 50,
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _githubIssuesCubit.close();
    super.dispose();
  }
}
