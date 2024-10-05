import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CTextField extends StatelessWidget {
  const CTextField({
    this.expands = false,
    this.labelText,
    this.labelStyle,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.enabled,
    this.autovalidateMode,
    this.margin = EdgeInsets.zero,
    this.decoration,
    this.cursorColor,
    this.validationMessage,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.showConterText = false,
    this.unFocusOnTapOutside = true,
    super.key,
    this.textDirection,
    this.strutStyle,
  });

  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final Color? cursorColor;
  final InputDecoration? decoration;
  final bool? enabled;
  final FocusNode? focusNode;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;
  final StrutStyle? strutStyle;
  final bool expands;

  final TextInputType? keyboardType;
  final TextStyle? labelStyle;
  final String? labelText;
  final EdgeInsetsGeometry margin;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final bool showConterText;
  final TextStyle? style;

  ///Text Alignment
  final TextAlign textAlign;

  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final String? validationMessage;
  final bool unFocusOnTapOutside;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextFormField(
        strutStyle: strutStyle,
        textDirection: textDirection,
        controller: controller,
        initialValue: initialValue,
        textAlign: textAlign,
        focusNode: focusNode,
        keyboardType: keyboardType,
        decoration: decoration,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        style: style,
        inputFormatters: inputFormatters,
        cursorColor: cursorColor,
        autofocus: autofocus,
        readOnly: readOnly,
        obscureText: obscureText,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        onTapOutside: unFocusOnTapOutside
            ? (event) => FocusScope.of(context).unfocus()
            : null,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        validator: validator ??
            (validationMessage != null
                ? (text) {
                    if ((text ?? '').trim().isEmpty) {
                      return validationMessage;
                    }
                    return null;
                  }
                : null),
        enabled: enabled,
        autovalidateMode: autovalidateMode,
      ),
    );
  }
}
