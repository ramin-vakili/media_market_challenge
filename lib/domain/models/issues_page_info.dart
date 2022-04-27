import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:media_market_challenge/domain/models/issue.dart';

/// A model class with the list of [Issue] and the page information to be used
/// for pagination of the issues retrieved.
@immutable
class IssuesPageInfo {
  const IssuesPageInfo({
    required this.issues,
    required this.hasPreviousPage,
    this.cursor,
  });

  /// Initializes an [IssuesPageInfo] with empty [issues] list.
  IssuesPageInfo.empty() : this(issues: <Issue>[], hasPreviousPage: false);

  factory IssuesPageInfo.fromJson(Map<String, dynamic> json) => IssuesPageInfo(
        issues: json['edges']
            .map<Issue>((dynamic e) => Issue.fromJson(e['node']))
            .toList(),
        hasPreviousPage: json['pageInfo']['hasPreviousPage'],
        cursor: json['pageInfo']['startCursor'],
      );

  final List<Issue> issues;
  final bool hasPreviousPage;
  final String? cursor;

  @override
  bool operator ==(covariant IssuesPageInfo other) =>
      listEquals(other.issues, issues) &&
      other.hasPreviousPage == hasPreviousPage &&
      other.cursor == cursor;

  @override
  int get hashCode => hashValues(issues, hasPreviousPage, cursor);
}
