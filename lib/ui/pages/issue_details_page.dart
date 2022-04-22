import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/data/services/graphql_services.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/state_management/github_issue_details/github_issue_details_cubit.dart';

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
      appBar: AppBar(title: const Text('Issue details')),
      body: BlocBuilder<GithubIssueDetailsCubit, GithubIssueDetailsState>(
        bloc: _issueDetailsCubit,
        builder: (_, GithubIssueDetailsState state) {
          if (state is GithubIssueDetailsLoadedState) {
            return SingleChildScrollView(
              child: Text(state.issueDetails.bodyHTML),
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
