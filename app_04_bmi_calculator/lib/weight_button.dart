import 'package:flutter/material.dart';

class WeightButton extends StatelessWidget {
  final IconData icon;
  final String size; // small, big
  final void Function() onTap;
  const WeightButton({
    super.key,
    required this.icon,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = size == "small" ? 26 : 36;
    return IconButton(
      onPressed: onTap,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(color: Colors.grey.shade400),
      ),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(16),
      //   border: BoxBorder.all(color: Colors.grey.shade600, width: 1),
      // ),
      icon: Icon(icon, size: iconSize),
    );
  }
}
