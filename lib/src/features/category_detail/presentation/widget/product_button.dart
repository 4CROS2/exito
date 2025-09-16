import 'package:exito/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class ProductButton extends StatefulWidget {
  const ProductButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  State<ProductButton> createState() => _ProductButtonState();
}

class _ProductButtonState extends State<ProductButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xfffd6709),
          borderRadius: Constants.innerBorderRadius,
        ),
        child: SizedBox(
          child: Center(
            child: Padding(
              padding: Constants.contentPadding,
              child: Text(
                'Agregar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
