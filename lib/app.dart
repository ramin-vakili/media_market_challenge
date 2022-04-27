import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/domain/repositories/visited_issues_repository.dart';
import 'package:media_market_challenge/ui/pages/home_page.dart';

import 'ui/state_management/github_issues/github_issues_cubit.dart';
import 'ui/state_management/visited_issues/visited_issues_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<GithubIssuesCubit>(
          create: (_) => GithubIssuesCubit(
            GetIt.instance.get<IssuesRepository>(),
          ),
        ),
        BlocProvider<VisitedIssuesCubit>(
          create: (_) =>
              VisitedIssuesCubit(GetIt.instance.get<VisitedIssuesRepository>())
                ..fetchVisitedIssues(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          dividerColor: const Color(0xffd7d7d7),
          primaryColor: const Color(0xfff7f8fa),
        ),
        home: const HomePage(),
      ),
    );
  }
}
