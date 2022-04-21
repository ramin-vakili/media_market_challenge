import 'package:flutter/cupertino.dart';

class Issue {
  const Issue({
    required this.id,
    required this.title,
    required this.url,
    required this.createdAt,
    required this.issueAuthor,
    this.number = 0,
    this.state = 'CLOSED',
  });

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        id: json['id'],
        title: json['title'],
        createdAt: DateTime.parse(json['createdAt']),
        url: json['url'],
        issueAuthor: IssueAuthor.fromJson(json['author']),
        number: json['number'],
        state: json['state'],
      );

  final String id;
  final String title;
  final DateTime createdAt;
  final String url;
  final IssueAuthor issueAuthor;
  final int number;
  final String state;

  @override
  bool operator ==(covariant Issue other) => other.id == id;

  @override
  int get hashCode => hashValues(
        id,
        title,
        createdAt,
        url,
        issueAuthor,
        number,
        state,
      );
}

class IssueAuthor {
  const IssueAuthor({required this.login, required this.avatarUrl});

  final String login;
  final String avatarUrl;

  factory IssueAuthor.fromJson(Map<String, dynamic> json) => IssueAuthor(
        login: json['login'],
        avatarUrl: json['avatarUrl'],
      );

  @override
  bool operator ==(covariant IssueAuthor other) =>
      other.login == login && other.avatarUrl == avatarUrl;

  @override
  int get hashCode => hashValues(login, avatarUrl);
}
