import 'package:flutter/material.dart';
import 'package:media_market_challenge/domain/models/issue.dart';

class IssueDetailsPage extends StatefulWidget {
  const IssueDetailsPage({required this.issue, Key? key}) : super(key: key);

  final Issue issue;

  @override
  _IssueDetailsPageState createState() => _IssueDetailsPageState();
}

class _IssueDetailsPageState extends State<IssueDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Issue details')),
      body: Text(widget.issue.title),
    );
  }
}
