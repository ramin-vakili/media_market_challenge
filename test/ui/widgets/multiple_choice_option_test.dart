import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_market_challenge/ui/widgets/multiple_choice_option.dart';

enum _MockEnum { case1, case2 }

void main() {
  Chip findChipWidget(WidgetTester tester, String name) =>
      tester.firstWidget(find.byType(Chip)) as Chip;

  group('MultiChoiceOption widget', () {
    testWidgets('onOptionSelected gets called if an item is selected', (
      WidgetTester tester,
    ) async {
      bool callbackCalled = false;
      List<_MockEnum>? selected;
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: MultipleChoiceOption<_MockEnum>(
            options: _MockEnum.values,
            selectedOptions: const <_MockEnum>[_MockEnum.case1],
            onOptionSelected: (List<_MockEnum> selectedOptions) {
              callbackCalled = true;
              selected = selectedOptions;
            },
          ),
        ),
      ));

      await tester.pump();
      await tester.tap(find.byKey(ValueKey<String>(_MockEnum.case2.name)));
      await tester.pumpAndSettle();

      expect(selected, <_MockEnum>[_MockEnum.case1, _MockEnum.case2]);
      expect(callbackCalled, true);
    });

    testWidgets('2nd option gets selected while 1st is also selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const _TestWrapper(
        selectedOptions: <_MockEnum>[_MockEnum.case1],
      ));

      await tester.pump();
      await tester.tap(find.byKey(ValueKey<String>(_MockEnum.case2.name)));
      await tester.pumpAndSettle();

      expect(
        findChipWidget(tester, _MockEnum.case1.name).backgroundColor,
        Colors.green,
      );

      expect(
        findChipWidget(tester, _MockEnum.case2.name).backgroundColor,
        Colors.green,
      );
    });

    testWidgets(
        'prevents 1st items get unselected because that is the only selected item',
        (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const _TestWrapper(
        selectedOptions: <_MockEnum>[_MockEnum.case1],
      ));

      await tester.pump();
      await tester.tap(find.byKey(ValueKey<String>(_MockEnum.case1.name)));
      await tester.pumpAndSettle();

      expect(
        findChipWidget(tester, _MockEnum.case1.name).backgroundColor,
        Colors.green,
      );
    });
  });
}

class _TestWrapper extends StatelessWidget {
  const _TestWrapper({Key? key, required this.selectedOptions})
      : super(key: key);

  final List<_MockEnum> selectedOptions;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Material(
          child: MultipleChoiceOption<_MockEnum>(
            options: _MockEnum.values,
            selectedOptions: selectedOptions,
          ),
        ),
      );
}
