import 'package:flutter/material.dart';
import 'package:media_market_challenge/domain/enums.dart';
import 'package:media_market_challenge/ui/widgets/select_ordering_dialog.dart';

Future<void> showSelectOrderingDialog({
  required BuildContext context,
  required IssueOrderField orderField,
  required OrderDirection orderDirection,
  required OnOrderingChanged onOrderingChanged,
}) async =>
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Select ordering'),
        content: SelectOrderingDialog(
          orderField: orderField,
          orderDirection: orderDirection,
          onOrderingChanged: onOrderingChanged,
        ),
      ),
    );
