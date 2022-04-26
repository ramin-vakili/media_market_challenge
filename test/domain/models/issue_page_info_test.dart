import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';

void main() {
  test('Issue fromJson', () {
    final IssuesPageInfo issuesPageInfo =
        IssuesPageInfo.fromJson(jsonDecode(_issuesMockData));

    expect(issuesPageInfo.issues.length, 2);
    expect(issuesPageInfo.hasPreviousPage, isTrue);
    expect(issuesPageInfo.cursor, '23&&HJ');

    final Issue issue = issuesPageInfo.issues.first;

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

const String _issuesMockData = '''{
  "edges" : [
          {
            "node": {
              "id": "I_kwDOAeUeuM5IJQZX",
              "title": "[fuchsia] Rename the test component `ime_service` to `text_manager`",
              "number": 102266,
              "state": "OPEN",
              "url": "https://github.com/flutter/flutter/issues/102266",
              "createdAt": "2022-04-21T01:29:38Z",
              "body": "This is body",
              "bodyHTML": "<body>This is body</body>",
              "author": {
                "login": "filmil",
                "avatarUrl": "https://avatars.githubusercontent.com/u/246576?v=4"
              }
            }
          },
          {
            "node": {
              "id": "I_kwDOAeUeuM5IJ_RQ",
              "title": "Problem in using didChangeAppLifecycleState",
              "number": 102278,
              "state": "OPEN",
              "url": "https://github.com/flutter/flutter/issues/102278",
              "createdAt": "2022-04-21T06:49:18Z",
              "author": {
                "login": "KK-Karan-Kumar",
                "avatarUrl": "https://avatars.githubusercontent.com/u/87383063?u=29a0cbc76f7a78e13e2e4943f9b4dd20fbac4ff4&v=4"
              }
            }
          }
      ],
  "pageInfo" : {
    "hasPreviousPage" : true,
    "startCursor" : "23&&HJ"
  }
}''';
