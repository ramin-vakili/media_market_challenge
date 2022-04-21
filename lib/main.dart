import 'package:flutter/material.dart';
import 'package:media_market_challenge/app_config.dart';
import 'package:media_market_challenge/tokens.dart';
import 'package:media_market_challenge/ui/state_management/github_issues/github_issues_cubit.dart';

import 'ui/pages/home_page.dart';

void main() {
  GithubIssuesCubit().connectToGraphQL(graphqlEndpoint, githubApiToken);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
