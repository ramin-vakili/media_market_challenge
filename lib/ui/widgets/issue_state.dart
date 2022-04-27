import 'package:flutter/material.dart';

class IssueStateOpen extends StatelessWidget {
  const IssueStateOpen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const _IssueState(
        color: Color(0xff21a954),
        state: 'Open',
        icon: Icons.adjust_outlined,
      );
}

class IssueStateClosed extends StatelessWidget {
  const IssueStateClosed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const _IssueState(
        color: Color(0xff7e4ed5),
        state: 'Closed',
        icon: Icons.check_circle_outline,
      );
}

class _IssueState extends StatelessWidget {
  const _IssueState({
    required this.color,
    required this.state,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final Color color;

  final String state;

  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 2),
            Text(
              state,
              style: const TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.fade,
            )
          ],
        ),
      );
}
