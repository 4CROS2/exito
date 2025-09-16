import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/core/extension/theme_extension.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatefulWidget {
  const CategoryTile({required this.index, super.key});

  final int index;

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Constants.animationDuration,
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
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.tertiaryColor,
          borderRadius: Constants.mainBorderRadius,
        ),
        child: Text('Category'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
