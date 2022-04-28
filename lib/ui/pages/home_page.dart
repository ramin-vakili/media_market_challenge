import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/domain/models/enums.dart';
import 'package:media_market_challenge/domain/models/fetch_issue_config.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/dialogs/filter_dialogs.dart';
import 'package:media_market_challenge/ui/state_management/github_issues/github_issues_cubit.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_cubit.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_state.dart';
import 'package:media_market_challenge/ui/widgets/github_app_bar.dart';
import 'package:media_market_challenge/ui/widgets/issue_item.dart';

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
        appBar: _buildAppBar(context),
        body: BlocBuilder<GithubIssuesCubit, GithubIssuesState>(
          bloc: _githubIssuesCubit,
          builder: (_, GithubIssuesState state) {
            if (state is GithubIssuesLoadedState) {
              return _buildIssuesList(state.issuesPageInfo.issues);
            } else if (state is GithubIssuesErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Align(
                child: CircularProgressIndicator(),
                alignment: Alignment.topCenter,
              );
            }
          },
        ),
      );

  PreferredSizeWidget _buildAppBar(BuildContext context) => GithubAppBar(
        title: const Text('MediaMarktChallenge'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSelectOrderingDialog(
                context: context,
                orderField: _githubIssuesCubit.currentConfig.orderBy,
                orderDirection: _githubIssuesCubit.currentConfig.direction,
                onOrderingChanged: (
                  IssueOrderField field,
                  OrderDirection direction,
                ) {
                  _githubIssuesCubit.updateOrder(
                    orderBy: field,
                    direction: direction,
                  );
                },
              );
            },
            icon: const Icon(Icons.sort_by_alpha),
          ),
          IconButton(
            onPressed: () {
              showSelectStateFilterDialog(
                context: context,
                states: _githubIssuesCubit.currentConfig.states,
                onStatesChanged: (List<IssueState> states) {
                  _githubIssuesCubit.updateStatesFilter(states: states);
                },
              );
            },
            icon: const Icon(Icons.check_circle_outline_rounded),
          ),
        ],
      );

  Widget _buildIssuesList(List<Issue> issues) =>
      BlocBuilder<VisitedIssuesCubit, VisitedIssuesState>(
          bloc: BlocProvider.of<VisitedIssuesCubit>(context),
          builder: (_, VisitedIssuesState visitedIssuesState) {
            if (visitedIssuesState is VisitedIssuesLoadedState) {
              return ListView.separated(
                controller: _scrollController,
                itemBuilder: (_, int index) {
                  late Widget item;

                  if (index == issues.length) {
                    item = const Center(child: CircularProgressIndicator());
                  } else {
                    item = IssueItem(
                      issue: issues[index],
                      isVisited:
                          visitedIssuesState.isIssueVisited(issues[index]),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: item,
                  );
                },
                itemCount: issues.length + 1,
                separatorBuilder: (_, int index) => Container(
                  width: double.infinity,
                  height: 2,
                  color: Theme.of(context).dividerColor,
                ),
              );
            }
            return const CircularProgressIndicator();
          });

  @override
  void dispose() {
    _githubIssuesCubit.close();
    super.dispose();
  }
}
