import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.onPressed, required this.child});
  final Function onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () => onPressed(),
        child: child,
      ),
    );
  }
}
