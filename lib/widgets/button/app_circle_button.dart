import 'package:flutter/material.dart';

class AppCircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? size;
  final double? iconSize;
  final IconData icon;
  final Color? color;
  const AppCircleButton({
    super.key,
    required this.onTap,
    this.size,
    this.iconSize,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> onTapDown = ValueNotifier(false);
    return ValueListenableBuilder(
      valueListenable: onTapDown,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: onTap,
          onTapDown: (details) {
            onTapDown.value = true;
          },
          onTapUp: (details) {
            onTapDown.value = false;
          },
          onTapCancel: () {
            onTapDown.value = false;
          },
          child: Container(
            width: size ?? 60,
            height: size ?? 60,
            decoration: BoxDecoration(
              color: value ? Colors.blue.shade200 : Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: iconSize ?? 35),
          ),
        );
      },
    );
  }
}
