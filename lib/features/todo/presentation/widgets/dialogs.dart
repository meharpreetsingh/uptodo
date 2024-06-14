import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class GetPriorityDialog extends StatefulWidget {
  final int initialPriority;
  const GetPriorityDialog({
    super.key,
    required this.initialPriority,
  });

  @override
  State<GetPriorityDialog> createState() => _GetPriorityDialogState();
}

class _GetPriorityDialogState extends State<GetPriorityDialog> {
  List<int> priorities = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int priority = 1;

  @override
  void initState() {
    priority = widget.initialPriority;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Todo Priority",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: priorities.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => gridOptionButton(
                context: context,
                icon: SvgPicture.asset(
                  "assets/svg/icons/flag.svg",
                  width: 26,
                  height: 26,
                  fit: BoxFit.contain,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                text: priorities[index].toString(),
                isCurrent: priority == priorities[index],
                selectedColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  context.pop(priorities[index]);
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        )),
                    onPressed: () {
                      Navigator.of(context).pop(widget.initialPriority); // Close Task Priority
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onSurface,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        )),
                    onPressed: () {
                      Navigator.of(context).pop(priority);
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

ElevatedButton gridOptionButton({
  required BuildContext context,
  required bool isCurrent,
  required Widget icon,
  required String text,
  required Function onPressed,
  Color? backgroundColor,
  Color? foregroundColor,
  Color? selectedColor,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor:
          (isCurrent && selectedColor != null) ? selectedColor : backgroundColor ?? Theme.of(context).colorScheme.background,
      foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    onPressed: () => onPressed(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}
