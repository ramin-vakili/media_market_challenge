import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/ui/widgets/single_choose_option.dart';

enum MockEnum { case1, case2 }

void main() {
  testWidgets('SingleChooseOption', (WidgetTester tester) async {
    bool callbackCalled = false;
    MockEnum? selected;
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: SingleChooseOption<MockEnum>(
          options: MockEnum.values,
          selectedOption: MockEnum.case1,
          onOptionSelected: (MockEnum selectedOption) {
            callbackCalled = true;
            selected = selectedOption;
          },
        ),
      ),
    ));

    await tester.pump();
    await tester.tap(find.byKey(ValueKey<String>(MockEnum.case2.name)));
    await tester.pumpAndSettle();

    expect(selected, MockEnum.case2);
    expect(callbackCalled, true);

    Chip findChipWidget(String name) =>
        tester.firstWidget(find.byType(Chip)) as Chip;

    expect(
      findChipWidget(MockEnum.case1.name).backgroundColor,
      Colors.grey.withOpacity(0.5),
    );
  });
}
