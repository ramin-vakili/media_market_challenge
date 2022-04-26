import 'package:flutter/material.dart';
import 'package:media_market_challenge/domain/enums.dart';
import 'package:media_market_challenge/ui/widgets/single_choose_option.dart';

typedef OnOrderingChanged = Function(IssueOrderField, OrderDirection);

class SelectOrderingDialog extends StatelessWidget {
  const SelectOrderingDialog({
    required this.orderField,
    required this.orderDirection,
    required this.onOrderingChanged,
    Key? key,
  }) : super(key: key);

  final IssueOrderField orderField;

  final OrderDirection orderDirection;

  final OnOrderingChanged onOrderingChanged;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChooseOption<IssueOrderField>(
            options: IssueOrderField.values,
            selectedOption: orderField,
            onOptionSelected: (IssueOrderField field) =>
                onOrderingChanged(field, orderDirection),
          ),
          SingleChooseOption<OrderDirection>(
            options: OrderDirection.values,
            selectedOption: orderDirection,
            onOptionSelected: (OrderDirection direction) =>
                onOrderingChanged(orderField, direction),
          )
        ],
      );
}
