import 'package:flutter/material.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/pages/issue_details_page.dart';
import 'package:media_market_challenge/ui/widgets/user_avatar.dart';

class IssueItem extends StatelessWidget {
  const IssueItem({required this.issue, Key? key}) : super(key: key);

  final Issue issue;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: UserAvatar(avatarUrl: issue.issueAuthor.avatarUrl),
        title: Text(issue.title),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => IssueDetailsPage(issue: issue),
          ),
        ),
      );
}
