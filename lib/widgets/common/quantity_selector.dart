import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Function(int) onChanged;
  final int maxQuantity;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.maxQuantity = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease Button
          IconButton(
            icon: const Icon(Icons.remove_rounded),
            onPressed: quantity > 1
                ? () => onChanged(quantity - 1)
                : null,
            style: IconButton.styleFrom(
              foregroundColor: quantity > 1 ? AppConstants.primaryColor : Colors.grey,
            ),
          ),
          
          // Quantity Display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Text(
              quantity.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Increase Button
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: quantity < maxQuantity
                ? () => onChanged(quantity + 1)
                : null,
            style: IconButton.styleFrom(
              foregroundColor: quantity < maxQuantity ? AppConstants.primaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}