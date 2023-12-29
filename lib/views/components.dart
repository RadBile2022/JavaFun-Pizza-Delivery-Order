import 'package:flutter/material.dart';

void showDialogBox(
  BuildContext context,
  String title,
  String subTitle,
  VoidCallback $onPressedDeleted,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete $title'),
        content: Text('Are you sure to delete "${subTitle.toUpperCase()}"'),
        actions: [
          TextButton(
            onPressed: $onPressedDeleted,
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
