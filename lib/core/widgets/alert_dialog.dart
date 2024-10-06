import 'package:flutter/material.dart';

import 'package:parking/core/helpers/logger.dart';
import 'package:parking/core/helpers/routing_helper.dart';

bool _dialogOpen = false;

Future<T?> cAlertDialog<T>(
    {required BuildContext context,
    required String message,
    List<Widget>? action}) {
  if (_dialogOpen) {
    printLog('multi Dialog');
    return Future.value();
  }
  _dialogOpen = true;
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
        actions: action ??
            [
              TextButton(
                child: const Text('Close'),
                onPressed: () => context.pop(),
              ),
            ],
      );
    },
  ).then((value) {
    _dialogOpen = false;
    return null;
  });
}
