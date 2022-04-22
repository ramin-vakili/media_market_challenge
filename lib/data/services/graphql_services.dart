import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
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
  Future<IssuesPageInfo> getIssues({
    String repoName = 'flutter',
    String repoOwner = 'flutter',
    int pageSize = 30,
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

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final Map<String, dynamic>? data = result.data;

    if (data != null) {
      final Map<String, dynamic> issuesRawResult = data['repository']['issues'];

      return IssuesPageInfo.fromJson(issuesRawResult);
    }

    return IssuesPageInfo.empty();
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
