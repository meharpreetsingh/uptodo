import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomUptodoDialog extends StatelessWidget {
  const CustomUptodoDialog({
    super.key,
    required this.title,
    required this.content,
    required this.showCancel,
    this.cancelText,
    required this.showConfirm,
    this.confirmText,
    this.onConfirm,
    this.onCancel,
  });
  final String title;
  final Widget content;
  final bool showCancel;
  final String? cancelText;
  final bool showConfirm;
  final String? confirmText;
  final Function? onConfirm;
  final Function? onCancel;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            thickness: 1,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          content,
          const SizedBox(height: 10),
          if (showCancel || showConfirm)
            Row(
              children: [
                if (showCancel)
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (onCancel != null) onCancel!();
                        context.pop();
                      },
                      child: Text(cancelText ?? "Cancel"),
                    ),
                  ),
                if (showCancel && showConfirm) const SizedBox(width: 10),
                if (showConfirm)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (onConfirm != null) onConfirm!();
                        context.pop();
                      },
                      child: Text(confirmText ?? "Confirm"),
                    ),
                  ),
              ],
            ),
        ],
      ),
    ));
  }
}
