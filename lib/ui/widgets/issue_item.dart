import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/ui/pages/issue_details_page.dart';
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
              builder: (_) => IssueDetailsPage(
                issue: issue,
                issuesRepository: GetIt.instance.get<IssuesRepository>(),
              ),
            ),
          );
        },
        trailing: isVisited ? const Icon(Icons.remove_red_eye) : null,
      );
}
