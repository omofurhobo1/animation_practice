import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  final Tween<double> _backgroundScale = Tween(begin: 0.0, end: 1);
  double _deviceRadius = 100;
  _HomePageState();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _animationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _pageBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _animatedContainer(),
              _starIcon(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      curve: Curves.easeInCirc,
      tween: _backgroundScale,
      duration: Duration(seconds: 2),
      builder: (_context, double _scale, _child) {
        return Transform.scale(
          scale: _scale,
          child: _child,
        );
      },
      child: Container(
        color: Colors.green,
      ),
    );
  }

  Widget _animatedContainer() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _deviceRadius += _deviceRadius == 200 ? -100 : _deviceRadius;
          });
        },
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          height: _deviceRadius,
          width: _deviceRadius,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Center(
              child: Text(
            "Congrats ):",
            style: TextStyle(
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          )),
        ),
      ),
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      animation: _animationController!.view,
      builder: (
        _buildContext,
        _child,
      ) {
        return Transform.rotate(
          angle: _animationController!.value * 2 * pi,
          child: _child,
        );
      },
      child: Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
