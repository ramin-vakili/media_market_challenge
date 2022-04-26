import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:media_market_challenge/data/services/graphql_services.dart';
import 'package:media_market_challenge/data/services/visited_issues_services.dart';
import 'package:media_market_challenge/domain/repositories/issues_repository.dart';
import 'package:media_market_challenge/domain/repositories/visited_issues_repository.dart';

import 'app.dart';

void main() {
  _setupServiceLocator();
  runApp(const MyApp());
}

void _setupServiceLocator() {
  GetIt.instance
    ..registerLazySingleton<IssuesRepository>(() => GraphqlIssuesService())
    ..registerLazySingleton<VisitedIssuesRepository>(
      () => SharedPrefVisitedIssuesService(),
    );
}


