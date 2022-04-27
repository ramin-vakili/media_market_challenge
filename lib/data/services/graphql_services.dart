import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:media_market_challenge/app_config.dart';
import 'package:media_market_challenge/domain/models/issue_details.dart';
import 'package:media_market_challenge/domain/models/issues_page_info.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/tokens.dart';

class GraphqlIssuesService implements IssuesRepository {
  factory GraphqlIssuesService() {
    return _instance ??= GraphqlIssuesService._internal(
      graphqlEndpoint,
      githubApiToken,
    );
  }

  GraphqlIssuesService._internal(String url, String token) {
    final HttpLink httpLink = HttpLink(url);

    _graphQLClient = GraphQLClient(
      link: AuthLink(getToken: () => 'Bearer $token').concat(httpLink),
      cache: GraphQLCache(),
    );
  }

  late final GraphQLClient _graphQLClient;

  static GraphqlIssuesService? _instance;

  @override
  Future<IssuesPageInfo> getIssues({
    required String repoName,
    required String repoOwner,
    int pageSize = 30,
    String? cursor,
    String orderBy = 'CREATED_AT',
    String direction = 'ASC',
    String issueState = 'ALL',
  }) async {
    final QueryResult<dynamic> result = await _graphQLClient.query<dynamic>(
      QueryOptions<dynamic>(
        document: gql(getIssuesQuery),
        variables: <String, dynamic>{
          'pageSize': pageSize,
          'owner': repoOwner,
          'name': repoName,
          'cursor': cursor,
          'orderBy': orderBy,
          'direction': direction,
          'stateFilter': issueState,
        },
      ),
    );

    final Map<String, dynamic>? data = result.data;

    if (result.hasException || data == null) {
      throw Exception(result.exception.toString());
    }

    final Map<String, dynamic> issuesRawResult = data['repository']['issues'];
    return IssuesPageInfo.fromJson(issuesRawResult);
  }

  @override
  Future<IssueDetails> getIssue({
    required String repoName,
    required String repoOwner,
    required int number,
  }) async {
    final QueryResult<dynamic> result = await _graphQLClient.query<dynamic>(
      QueryOptions<dynamic>(
        document: gql(getIssueQuery),
        variables: <String, dynamic>{
          'number': number,
          'owner': repoOwner,
          'name': repoName,
        },
      ),
    );

    final Map<String, dynamic>? data = result.data;

    if (result.hasException || data == null) {
      throw Exception(result.exception.toString());
    }

    return IssueDetails.fromJson(data['repository']['issue']);
  }
}

const String getIssuesQuery = r'''
      query getIssuesQuery(
        $pageSize: Int!, 
        $owner: String!, 
        $name: String!, 
        $cursor: String,
        $orderBy: IssueOrderField!,
        $direction: OrderDirection!,
        $stateFilter: [IssueState!],
      ) {
          repository(owner: $owner, name: $name) {
            issues(
              last: $pageSize
              before: $cursor
              orderBy: {field: $orderBy, direction: $direction}
              filterBy: {states: $stateFilter}
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

const String getIssueQuery =
    r'''query getIssueQuery($number: Int!, $owner: String!, $name: String!){
	repository(owner: $owner, name: $name) {
  	issue(
    	number: $number
    ) {
    	id
      title
      state
      createdAt
      body
      bodyHTML
      url
      number
      author {
        login
        avatarUrl
      }
    }
  }
}''';
