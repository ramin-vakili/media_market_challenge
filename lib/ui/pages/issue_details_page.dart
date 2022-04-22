import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:media_market_challenge/data/services/graphql_services.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/state_management/github_issue_details/github_issue_details_cubit.dart';
import 'package:media_market_challenge/ui/widgets/user_avatar.dart';

class IssueDetailsPage extends StatefulWidget {
  const IssueDetailsPage({required this.issue, Key? key}) : super(key: key);

  final Issue issue;

  @override
  _IssueDetailsPageState createState() => _IssueDetailsPageState();
}

class _IssueDetailsPageState extends State<IssueDetailsPage> {
  late final GithubIssueDetailsCubit _issueDetailsCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _issueDetailsCubit = GithubIssueDetailsCubit(GraphqlIssuesService())
      ..fetchIssue(
        number: widget.issue.number,
      );
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
      body: BlocBuilder<GithubIssueDetailsCubit, GithubIssueDetailsState>(
        bloc: _issueDetailsCubit,
        builder: (_, GithubIssueDetailsState state) {
          if (state is GithubIssueDetailsLoadedState) {
            return SingleChildScrollView(
              child: Html(data: state.issueDetails.bodyHTML),
            );
          } else if (state is GithubIssueDetailsErrorState) {
            return Text(state.message);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    _issueDetailsCubit.close();
    super.dispose();
  }
}
