import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void push(Widget child) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => child),
    );
  }

  void pushReplacement(Widget child) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => child),
    );
  }

  void pushAndRemoveUntil(Widget child, {bool removeUntilHome = false}) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => child),
      (route) => false,
    );
  }

  void pop([dynamic result]) {
    Navigator.pop(this, result);
  }
}
