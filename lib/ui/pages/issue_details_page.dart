import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/ui/state_management/github_issue_details/github_issue_details_cubit.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_cubit.dart';
import 'package:media_market_challenge/ui/widgets/issue_details_header.dart';
import 'package:media_market_challenge/ui/widgets/issue_state.dart';
import 'package:media_market_challenge/ui/widgets/user_avatar.dart';

DateFormat _formatter = DateFormat('yyyy-MM-dd');

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
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _buildUserAndDateInfo(),
            SliverToBoxAdapter(
              child: _buildIssueDetailsSection(),
            ),
            const SliverFillRemaining()
          ],
        ),
      ),
    );
  }

  SliverPersistentHeader _buildUserAndDateInfo() => SliverPersistentHeader(
        delegate: IssueDetailsHeader(
          buildIcon: (double size) => Hero(
            tag: widget.issue.id,
            child: UserAvatar(
              width: size,
              height: size,
              avatarUrl: widget.issue.issueAuthor.avatarUrl,
            ),
          ),
          title: widget.issue.issueAuthor.login,
          title2: _formatter.format(widget.issue.createdAt),
        ),
        pinned: true,
      );

  BlocBuilder<GithubIssueDetailsCubit, GithubIssueDetailsState>
      _buildIssueDetailsSection() {
    return BlocBuilder<GithubIssueDetailsCubit, GithubIssueDetailsState>(
      bloc: _issueDetailsCubit,
      builder: (_, GithubIssueDetailsState state) {
        if (state is GithubIssueDetailsLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(child: _buildIssueTItle(state)),
                    const SizedBox(width: 4),
                    state.issueDetails.state == IssueState.open
                        ? const IssueStateOpen()
                        : const IssueStateClosed()
                  ],
                ),
                _buildIssueBody(state),
              ],
            ),
          );
        } else if (state is GithubIssueDetailsErrorState) {
          return Text(state.message);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Text _buildIssueTItle(GithubIssueDetailsLoadedState state) {
    return Text(
      state.issueDetails.title,
      style: const TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _buildIssueBody(GithubIssueDetailsLoadedState state) =>
      Html(data: state.issueDetails.bodyHTML);

  @override
  void dispose() {
    _issueDetailsCubit.close();
    super.dispose();
  }
}
