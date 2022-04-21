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
        state: json['state'],
        createdAt: DateTime.parse(json['createdAt']),
        url: json['url'],
        number: json['number'],
        issueAuthor: IssueAuthor.fromJson(json['author']),
      );

  final String id;
  final String title;
  final String state;
  final DateTime createdAt;
  final String url;
  final int number;
  final IssueAuthor issueAuthor;

  @override
  bool operator ==(covariant Issue other) => other.id == id;

  @override
  int get hashCode => hashValues(
        id,
        title,
        state,
        createdAt,
        url,
        number,
        issueAuthor,
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
