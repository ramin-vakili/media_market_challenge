import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/ui/widgets/single_choose_option.dart';

enum _MockEnum { case1, case2 }

void main() {
  testWidgets('SingleChooseOption', (WidgetTester tester) async {
    bool callbackCalled = false;
    _MockEnum? selected;
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: SingleChooseOption<_MockEnum>(
          options: _MockEnum.values,
          selectedOption: _MockEnum.case1,
          onOptionSelected: (_MockEnum selectedOption) {
            callbackCalled = true;
            selected = selectedOption;
          },
        ),
      ),
    ));

    await tester.pump();
    await tester.tap(find.byKey(ValueKey<String>(_MockEnum.case2.name)));
    await tester.pumpAndSettle();

    expect(selected, _MockEnum.case2);
    expect(callbackCalled, true);

    Chip findChipWidget(String name) =>
        tester.firstWidget(find.byType(Chip)) as Chip;

    expect(
      findChipWidget(_MockEnum.case1.name).backgroundColor,
      Colors.grey.withOpacity(0.5),
    );
  });
}
