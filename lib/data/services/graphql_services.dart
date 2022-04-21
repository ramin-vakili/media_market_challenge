import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';

class GraphqlIssuesService implements IssuesRepository {
  GraphqlIssuesService(String url, String token) {
    final HttpLink httpLink = HttpLink(url);

    _graphQLClient = GraphQLClient(
      link: AuthLink(getToken: () => 'Bearer $token').concat(httpLink),
      cache: GraphQLCache(),
    );
  }

  late final GraphQLClient _graphQLClient;

  @override
  Future<List<Issue>> getIssues({
    String repoName = 'flutter',
    String repoOwner = 'flutter',
    int pageSize = 20,
    String? cursor,
  }) async {
    final QueryResult<dynamic> result = await _graphQLClient.query<dynamic>(
      QueryOptions<dynamic>(
        document: gql(getIssuesQuery),
        variables: <String, dynamic>{
          'pageSize': pageSize,
          'cursor': cursor,
        },
      ),
    );

    final Map<String, dynamic>? data = result.data;

    if (data != null) {
      final List<dynamic> issuesRawList = data['repository']['issues']['edges'];

      return issuesRawList
          .map<Issue>((dynamic e) => Issue.fromJson(e['node']))
          .toList();
    }

    return <Issue>[];
  }
}

const String getIssuesQuery = r'''
      query getIssuesQuery($pageSize: Int!, $cursor: String) {
        repository(owner: "flutter", name: "flutter") {
          issues(
            last: $pageSize
            before: $cursor
            orderBy: {field: CREATED_AT, direction: ASC}
            filterBy: {states: OPEN}
          ) {
            edges {
              node {
                id
                title
                state
                createdAt
                url
                number
                author {
                  login
                  avatarUrl
                }
              }
            }
            pageInfo {
              hasPreviousPage
              startCursor
            }
          }
        }
      }
''';
