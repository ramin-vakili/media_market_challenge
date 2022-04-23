import 'package:media_market_challenge/domain/enums.dart';

RegExp regExp = RegExp(r'(?<=[a-z])[A-Z]');

/// Converts camelCase names to SNAKE_CASE all uppercase.
/// e.g. createdAt -> CREATED_AT
String _convertCamelToSnakeUppercase(String camelCaseString) => camelCaseString
    .replaceAllMapped(regExp, (Match m) => '_${m.group(0)}')
    .toUpperCase();

extension IssueOrderFieldExtension on IssueOrderField {
  String get snakeCaseName => _convertCamelToSnakeUppercase(name);
}

extension OrderDirectionExtension on OrderDirection {
  String get snakeCaseName => _convertCamelToSnakeUppercase(name);
}