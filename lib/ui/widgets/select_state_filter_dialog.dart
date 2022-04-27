import 'package:flutter/material.dart';
import 'package:media_market_challenge/domain/models/issue.dart';

import 'multiple_choice_option.dart';

typedef OnStatesChanged = Function(List<IssueState>);

class SelectStateFilterDialog extends StatelessWidget {
  const SelectStateFilterDialog({
    required this.issuesState,
    required this.onStatesChanged,
    Key? key,
  }) : super(key: key);

  final List<IssueState> issuesState;

  final OnStatesChanged onStatesChanged;

  @override
  Widget build(BuildContext context) => MultipleChoiceOption<IssueState>(
        options: IssueState.values,
        selectedOptions: issuesState,
        onOptionSelected: (List<IssueState> selectedStates) =>
            onStatesChanged(selectedStates),
      );
}
