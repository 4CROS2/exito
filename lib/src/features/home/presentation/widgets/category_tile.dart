import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/widgets/image_loader.dart';
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
      child: ClipRRect(
        borderRadius: Constants.mainBorderRadius,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ShaderMask(
                blendMode: BlendMode.darken,
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,

                    colors: <Color>[
                      Colors.transparent,
                      Colors.black26,
                      Colors.black54,
                      Colors.black87,
                      Colors.black,
                    ],
                    stops: <double>[0, 0.5, 0.7, 0.9, 1],
                  ).createShader(bounds);
                },
                child: const ImageLoader(
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Koenigsegg_Jesko%2C_GIMS_2019%2C_Le_Grand-Saconnex_%28GIMS1045%29.jpg/1200px-Koenigsegg_Jesko%2C_GIMS_2019%2C_Le_Grand-Saconnex_%28GIMS1045%29.jpg',
                ),
              ),
            ),
            const Positioned(
              bottom: Constants.mainPaddingValue,
              left: 0,
              right: 0,
              child: Text(
                'Koenigsegg Jesko',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
