import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'github_issues_state.dart';

class GithubIssuesCubit extends Cubit<GithubIssuesState> {
  GithubIssuesCubit() : super(GithubIssuesLoadingState());

  void connectToGraphQL(String url, String token) async {
    final HttpLink httpLink = HttpLink(url);

    final GraphQLClient graphQLClient = GraphQLClient(
      link: AuthLink(getToken: () => 'Bearer $token').concat(httpLink),
      cache: GraphQLCache(),
    );

    final QueryResult<dynamic> result = await graphQLClient.query<dynamic>(
      QueryOptions(
        document: gql(getIssuesQuery),
      ),
    );

    final Map<String, dynamic>? data = result.data;

    if (data != null) {
      final List<dynamic> issuesRawList = data['repository']['issues']['edges'];
    }
  }
}

const String getIssuesQuery = r'''
      query getIssuesQuery() {
        repository(owner: "flutter", name: "flutter") {
          issues(
            last: 20
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
