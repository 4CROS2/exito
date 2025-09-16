import 'package:flutter/material.dart';

class CartButton extends StatefulWidget {
  const CartButton({required this.onTap, required this.itemCount, super.key});
  final VoidCallback? onTap;
  final int itemCount;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onTap,
      icon: Badge.count(
        count: widget.itemCount,
        isLabelVisible: widget.itemCount > 0,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
