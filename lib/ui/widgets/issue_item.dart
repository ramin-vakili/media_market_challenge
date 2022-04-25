import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/pages/issue_details_page.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_cubit.dart';
import 'package:media_market_challenge/ui/widgets/user_avatar.dart';

class IssueItem extends StatelessWidget {
  const IssueItem({required this.issue, Key? key, this.isVisited = false})
      : super(key: key);

  final Issue issue;
  final bool isVisited;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Hero(
          tag: issue.id,
          child: UserAvatar(avatarUrl: issue.issueAuthor.avatarUrl),
        ),
        title: Text(issue.title),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => IssueDetailsPage(issue: issue),
            ),
          );

          BlocProvider.of<VisitedIssuesCubit>(context).markAsVisited(issue);
        },
        trailing: isVisited ? const Icon(Icons.remove_red_eye) : null,
      );
}
