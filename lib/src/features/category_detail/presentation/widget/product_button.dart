import 'package:exito/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class ProductButton extends StatefulWidget {
  const ProductButton({
    required this.label,
    super.key,
    this.color,
    this.suffixIcon,
    this.onTap,
  });
  final VoidCallback? onTap;
  final Color? color;
  final String label;
  final Widget? suffixIcon;

  @override
  State<ProductButton> createState() => _ProductButtonState();
}

class _ProductButtonState extends State<ProductButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.color ?? const Color(0xfffd6709),
          borderRadius: Constants.innerBorderRadius,
        ),
        child: SizedBox(
          child: Center(
            child: Padding(
              padding: Constants.contentPadding,
              child: Row(
                spacing: Constants.mainPaddingValue,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.suffixIcon != null) widget.suffixIcon!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
