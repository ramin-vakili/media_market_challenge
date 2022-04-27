import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:media_market_challenge/domain/models/issue.dart';

import 'enums.dart';

@immutable
class FetchIssuesConfig {
  const FetchIssuesConfig({
    this.orderBy = IssueOrderField.createdAt,
    this.direction = OrderDirection.asc,
    this.states = const <IssueState>[IssueState.open, IssueState.closed],
    this.pageSize = 20,
    this.repoName = 'flutter',
    this.repoOwner = 'flutter',
    this.cursor,
  });

  final IssueOrderField orderBy;
  final OrderDirection direction;
  final List<IssueState> states;
  final int pageSize;
  final String repoName;
  final String repoOwner;
  final String? cursor;

  FetchIssuesConfig copyWith({
    IssueOrderField? orderBy,
    OrderDirection? direction,
    int? pageSize,
    String? repoName,
    String? repoOwner,
    List<IssueState>? states,
    String? cursor,
  }) =>
      FetchIssuesConfig(
        orderBy: orderBy ?? this.orderBy,
        direction: direction ?? this.direction,
        pageSize: pageSize ?? this.pageSize,
        repoName: repoName ?? this.repoName,
        repoOwner: repoOwner ?? this.repoOwner,
        states: states ?? this.states,
        cursor: cursor ?? this.cursor,
      );

  @override
  bool operator ==(covariant FetchIssuesConfig other) =>
      other.orderBy == orderBy &&
      other.direction == direction &&
      other.repoName == repoName &&
      other.repoOwner == repoOwner &&
      other.pageSize == pageSize &&
      other.states == states &&
      other.cursor == cursor;

  @override
  int get hashCode => hashValues(
        orderBy,
        direction,
        repoName,
        repoOwner,
        pageSize,
        states,
        cursor,
      );
}
