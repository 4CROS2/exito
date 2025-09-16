import 'package:flutter/material.dart';

class FadeWidget extends StatefulWidget {
  const FadeWidget({
    required this.index,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 500),
    super.key,
  });
  final int index;
  final Duration animationDuration;
  final Widget child;

  @override
  State<FadeWidget> createState() => _FadeWidgetState();
}

class _FadeWidgetState extends State<FadeWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future<void>.delayed(
      Duration(milliseconds: (80 * widget.index).clamp(0, 600)),
      () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(0, 10 * (1 - _animation.value)),
          child: FadeTransition(opacity: _animation, child: child),
        );
      },
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
