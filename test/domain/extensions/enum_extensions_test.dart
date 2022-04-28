import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/models/enums.dart';
import 'package:media_market_challenge/domain/extensions/enum_extensions.dart';
import 'package:media_market_challenge/domain/models/issue.dart';

void main() {
  group('enum extensions', () {
    group('IssueOrderFieldExtension cases', () {
      test('converts camelCase to Snake upper case', () {
        expect(IssueOrderField.createdAt.screamingSnakeCaseName, 'CREATED_AT');
        expect(IssueOrderField.updatedAt.screamingSnakeCaseName, 'UPDATED_AT');
        expect(IssueOrderField.comments.screamingSnakeCaseName, 'COMMENTS');
      });
    });

    group('OrderDirectionExtension cases', () {
      test('converts camelCase to Snake upper case', () {
        expect(OrderDirection.asc.screamingSnakeCaseName, 'ASC');
        expect(OrderDirection.desc.screamingSnakeCaseName, 'DESC');
      });
    });

    group('IssueState cases', () {
      test('converts camelCase to Snake upper case', () {
        expect(IssueState.open.screamingSnakeCaseName, 'OPEN');
        expect(IssueState.closed.screamingSnakeCaseName, 'CLOSED');
      });
    });
  });
}
