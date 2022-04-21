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

    print(result);
  }
}

const String getIssuesQuery = r'''
      query getIssuesQuery() {
        repository(owner: "flutter", name: "flutter") {
          issues(
            last: 10
            orderBy: {field: CREATED_AT, direction: ASC}
            filterBy: {states: OPEN}
          ) {
            edges {
              node {
                id
                title
                url
              }
            }
          }
        }
      }
''';
