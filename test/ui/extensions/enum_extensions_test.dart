import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/domain/enums.dart';
import 'package:media_market_challenge/ui/extensions/enum_extensions.dart';

void main() {
  group('enum extensions', () {
    group('IssueOrderFieldExtension cases', () {
      test('converts camelCase to Snake upper case', () {
        const IssueOrderField field = IssueOrderField.createdAt;

        expect(field.snakeCaseName, 'CREATED_AT');
      });
    });

    group('OrderDirectionExtension cases', () {
      test('converts camelCase to Snake upper case', () {
        const OrderDirection direction = OrderDirection.asc;

        expect(direction.snakeCaseName, 'ASC');
      });
    });
  });
}
