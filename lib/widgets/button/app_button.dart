import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsets? padding;
  final bool? showTitle;
  const AppButton({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.showTitle = true,
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
          child: Container(
            width: width ?? double.infinity,
            height: height ?? 50,
            padding:
                padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color:
                  onTapDown.value
                      ? backgroundColor.withValues(alpha: 0.5)
                      : backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius ?? 100),
            ),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: textColor),
                if (showTitle!) Text(title, style: TextStyle(color: textColor)),
              ],
            ),
          ),
        );
      },
    );
  }
}
