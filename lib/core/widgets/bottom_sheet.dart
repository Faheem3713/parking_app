import 'package:flutter/material.dart';

Future<T?> cShowModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  Color? color = Colors.white,
  bool isScrollControlled = false,
  bool isDismissible = true,
  double? height,
  bool? showDragHandle,
  bool useSafeArea = true,
  ShapeBorder? shape,
  Clip? clipBehavior,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: color,
    isDismissible: isDismissible,
    useSafeArea: useSafeArea,
    showDragHandle: showDragHandle,
    shape: shape,
    clipBehavior: clipBehavior,
    builder: (BuildContext context) => SizedBox(
      height: height,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: color,
        child: child,
      ),
    ),
  );
}
