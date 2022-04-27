import 'package:flutter/foundation.dart';
import 'package:media_market_challenge/domain/models/issue.dart';

@immutable
class IssueDetails extends Issue {
  const IssueDetails({
    required String id,
    required String title,
    required DateTime createdAt,
    required String url,
    required IssueAuthor issueAuthor,
    required this.body,
    required this.bodyHTML,
    int number = 0,
    IssueState state = IssueState.closed,
  }) : super(
    id: id,
    title: title,
    createdAt: createdAt,
    url: url,
    issueAuthor: issueAuthor,
    number: number,
    state: state,
  );

  factory IssueDetails.fromJson(Map<String, dynamic> json) =>
      IssueDetails(
        id: json['id'],
        title: json['title'],
        createdAt: DateTime.parse(json['createdAt']),
        url: json['url'],
        issueAuthor: IssueAuthor.fromJson(json['author']),
        body: json['body'],
        bodyHTML: json['bodyHTML'],
        number: json['number'],
        state: json['state'] == 'OPEN' ? IssueState.open : IssueState.closed,
      );

  final String body;
  final String bodyHTML;
}
