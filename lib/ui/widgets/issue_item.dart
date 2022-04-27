import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/ui/pages/issue_details_page.dart';
import 'package:media_market_challenge/ui/widgets/issue_state.dart';
import 'package:media_market_challenge/ui/widgets/user_avatar.dart';

class IssueItem extends StatelessWidget {
  const IssueItem({required this.issue, Key? key, this.isVisited = false})
      : super(key: key);

  final Issue issue;
  final bool isVisited;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 64,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
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
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 64,
                  child: Hero(
                    tag: issue.id,
                    child: UserAvatar(avatarUrl: issue.issueAuthor.avatarUrl),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(child: Text(issue.title)),
                const SizedBox(width: 8),
                SizedBox(
                  child: Column(
                    children: <Widget>[
                      _buildIsVisited(),
                      issue.state == IssueState.open
                          ? const IssueStateOpen()
                          : const IssueStateClosed()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget _buildIsVisited() =>
      isVisited ? const Icon(Icons.remove_red_eye) : const SizedBox(height: 16);
}
