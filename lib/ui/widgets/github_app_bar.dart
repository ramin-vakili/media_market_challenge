import 'package:flutter/material.dart';

class GithubAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GithubAppBar({Key? key, required this.title, required this.actions})
      : super(key: key);

  final Widget title;

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: <Widget>[Expanded(child: title), ...actions],
              ),
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => const Size(double.infinity, 96);
}
