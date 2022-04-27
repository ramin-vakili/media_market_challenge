import 'package:flutter/material.dart';
import 'package:media_market_challenge/domain/models/enums.dart';
import 'package:media_market_challenge/domain/models/issue.dart';
import 'package:media_market_challenge/ui/dialogs/dialog_wrapper.dart';
import 'package:media_market_challenge/ui/widgets/select_ordering_dialog.dart';
import 'package:media_market_challenge/ui/widgets/select_state_filter_dialog.dart';

Future<void> showSelectOrderingDialog({
  required BuildContext context,
  required IssueOrderField orderField,
  required OrderDirection orderDirection,
  required OnOrderingChanged onOrderingChanged,
}) async =>
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => DialogWrapper(
        child: AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Issues\' order'),
          content: SelectOrderingDialog(
            orderField: orderField,
            orderDirection: orderDirection,
            onOrderingChanged: onOrderingChanged,
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );

Future<void> showSelectStateFilterDialog({
  required BuildContext context,
  required List<IssueState> states,
  required OnStatesChanged onStatesChanged,
}) async =>
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => DialogWrapper(
        child: AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Issues\' state'),
          content: SelectStateFilterDialog(
            issuesState: states,
            onStatesChanged: onStatesChanged,
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
