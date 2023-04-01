import 'package:flutter/material.dart';

class MyRotatingImage extends StatefulWidget {
  @override
  _MyRotatingImageState createState() => _MyRotatingImageState();
}

class _MyRotatingImageState extends State<MyRotatingImage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 2), vsync: this)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset('assets/images/white.png'),
    );
  }
}
