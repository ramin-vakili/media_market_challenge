import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/ui/state_management/github_issue_details/github_issue_details_cubit.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_cubit.dart';
import 'package:media_market_challenge/ui/widgets/user_avatar.dart';

class IssueDetailsPage extends StatefulWidget {
  const IssueDetailsPage({
    required this.issue,
    required this.issuesRepository,
    Key? key,
  }) : super(key: key);

  final Issue issue;

  final IssuesRepository issuesRepository;

  @override
  _IssueDetailsPageState createState() => _IssueDetailsPageState();
}

class _IssueDetailsPageState extends State<IssueDetailsPage> {
  late final GithubIssueDetailsCubit _issueDetailsCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _issueDetailsCubit = GithubIssueDetailsCubit(widget.issuesRepository)
      ..fetchIssue(
        number: widget.issue.number,
      );

    BlocProvider.of<VisitedIssuesCubit>(context).markAsVisited(widget.issue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Hero(
            tag: widget.issue.id,
            child: UserAvatar(
              width: 32,
              height: 32,
              avatarUrl: widget.issue.issueAuthor.avatarUrl,
            ),
          ),
        ),
        title: const Text('Issue details'),
      ),
      body: _buildIssueDetailsSection(),
    );
  }

  BlocBuilder<GithubIssueDetailsCubit, GithubIssueDetailsState>
      _buildIssueDetailsSection() {
    return BlocBuilder<GithubIssueDetailsCubit, GithubIssueDetailsState>(
      bloc: _issueDetailsCubit,
      builder: (_, GithubIssueDetailsState state) {
        if (state is GithubIssueDetailsLoadedState) {
          return Column(
            children: <Widget>[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(state.issueDetails.issueAuthor.login),
                  Text(state.issueDetails.createdAt.toIso8601String()),
                ],
              ),
              Expanded(child: _buildIssueBody(state)),
            ],
          );
        } else if (state is GithubIssueDetailsErrorState) {
          return Text(state.message);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildIssueBody(GithubIssueDetailsLoadedState state) =>
      SingleChildScrollView(child: Html(data: state.issueDetails.bodyHTML));

  @override
  void dispose() {
    _issueDetailsCubit.close();
    super.dispose();
  }
}
