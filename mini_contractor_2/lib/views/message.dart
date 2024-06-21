import 'package:flutter/material.dart';
import 'package:mini_contractor_2/constant.dart';

class StatusDialog extends StatelessWidget {
  final bool success;
  final dynamic data;

  StatusDialog({required this.success, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(success ? 'Success' : 'Failure'),
      content: Row(
        children: <Widget>[
          success
              ? Icon(Icons.check_circle, color: customColor)
              : Icon(Icons.error_outline, color: customColor),
          SizedBox(width: 10),
          Expanded(child: Text(data.toString())),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
