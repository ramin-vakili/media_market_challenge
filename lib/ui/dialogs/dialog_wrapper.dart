import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogWrapper extends StatefulWidget {
  const DialogWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<DialogWrapper> createState() => _DialogWrapperState();
}

class _DialogWrapperState extends State<DialogWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final Curve _curve = Curves.easeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, Widget? child) => Transform.scale(
        scale: _curve.transform(_controller.value),
        child: child,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.22,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: widget.child,
      ),
    );
  }
}
