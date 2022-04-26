import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/models/issue.dart';

import '../../ui/state_management/github_issues/issues_mock_data.dart';

void main() {
  test('Issue fromJson', () {
    final Issue issue =
        Issue.fromJson(jsonDecode(issuesMockData).first['node']);

    expect(issue.id, 'I_kwDOAeUeuM5IJQZX');
    expect(issue.state, 'OPEN');
    expect(issue.title, contains('Rename the test component'));
    expect(issue.number, 102266);
    expect(issue.url, 'https://github.com/flutter/flutter/issues/102266');
    expect(issue.createdAt.toString(), contains('2022-04-21'));
    expect(issue.issueAuthor.login, 'filmil');
    expect(
      issue.issueAuthor.avatarUrl,
      'https://avatars.githubusercontent.com/u/246576?v=4',
    );
  });
}
