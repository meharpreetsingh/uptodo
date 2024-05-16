import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateUsernameDialog extends StatefulWidget {
  const UpdateUsernameDialog({super.key, required this.initialValue});
  final String initialValue;
  @override
  State<UpdateUsernameDialog> createState() => _UpdateUsernameDialogState();
}

class _UpdateUsernameDialogState extends State<UpdateUsernameDialog> {
  late TextEditingController nameController;
  String errorText = "";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
      titleTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      title: const Center(child: Text("Edit Name")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            height: 2,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: nameController,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => context.pop(),
                  child: const Text("Cancel"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    if (nameController.value.text.length < 5) {
                      return setState(() => errorText = "Name must be at least 5 characters long");
                    }
                    context.pop(nameController.value.text);
                  },
                  child: const Text("Confirm"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
