import 'package:flutter/material.dart';

class AdjustMentBuilder extends StatelessWidget {
  const AdjustMentBuilder(
      {super.key, required this.onPressed, required this.icon});
  final VoidCallback onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
          onPressed: onPressed,
          icon: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(6)),
            child: Icon(icon, size: 18),
          )),
    );
  }
}
