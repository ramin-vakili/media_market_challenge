import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_market_challenge/data/services/graphql_services.dart';
import 'package:media_market_challenge/data/services/visited_issues_services.dart';
import 'package:media_market_challenge/ui/state_management/github_issues/github_issues_cubit.dart';
import 'package:media_market_challenge/ui/state_management/visited_issues/visited_issues_cubit.dart';

import 'ui/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<GithubIssuesCubit>(
          create: (_) => GithubIssuesCubit(GraphqlIssuesService()),
        ),
        BlocProvider<VisitedIssuesCubit>(
          create: (_) =>
              VisitedIssuesCubit(VisitedIssuesService())..fetchVisitedIssues(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
