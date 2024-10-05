import 'dart:convert';
import 'dart:developer';

void printLog(
  Object? message, {
  String name = 'Log',
}) {
  Object? encodedMessage;
  try {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    encodedMessage = encoder.convert(message);
  } catch (_) {
    encodedMessage = message;
  }
  log(
    '$encodedMessage',
  );
}
