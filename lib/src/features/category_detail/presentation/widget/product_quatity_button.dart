import 'package:exito/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class ProductQuantityButton extends StatefulWidget {
  const ProductQuantityButton({
    required this.quantity,
    this.onAdd,
    this.onRemove,
    super.key,
  });
  final int quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  @override
  State<ProductQuantityButton> createState() => _ProductQuantityButtonState();
}

class _ProductQuantityButtonState extends State<ProductQuantityButton> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xffefefef),
        borderRadius: Constants.innerBorderRadius,
      ),
      child: Padding(
        padding: Constants.mainPaddingAll,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _actionButton(icon: Icons.remove, onTap: widget.onRemove),
            Text(
              widget.quantity.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _actionButton(icon: Icons.add, onTap: widget.onAdd),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Constants.primaryLightColor,
          borderRadius: Constants.innerBorderRadius / 2,
          border: Border.all(color: Colors.black45, width: 1),
        ),
        child: Padding(
          padding: Constants.mainPaddingAll * 1.2,
          child: Icon(icon, color: Colors.black, size: 18),
        ),
      ),
    );
  }
}
