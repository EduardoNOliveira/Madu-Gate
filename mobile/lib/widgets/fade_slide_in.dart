import 'dart:async';

import 'package:flutter/material.dart';

class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offsetY = 0.08,
    this.duration = const Duration(milliseconds: 540),
    this.curve = Curves.easeOutCubic,
  });

  final Widget child;
  final Duration delay;
  final double offsetY;
  final Duration duration;
  final Curve curve;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn> {
  bool _visible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: widget.duration,
      curve: widget.curve,
      offset: _visible ? Offset.zero : Offset(0, widget.offsetY),
      child: AnimatedOpacity(
        duration: widget.duration,
        curve: widget.curve,
        opacity: _visible ? 1 : 0,
        child: widget.child,
      ),
    );
  }
}
