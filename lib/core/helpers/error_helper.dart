import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:parking/controllers/auth_controller.dart';
import 'package:parking/controllers/parking_controller.dart';
import 'package:parking/core/widgets/alert_dialog.dart';
import 'package:parking/core/helpers/logger.dart';
import 'package:parking/core/helpers/ui_helpers.dart';
import 'package:provider/provider.dart';

class ErrorHelper {
  static Future<void> handleError(Future<void> Function() data) async {
    try {
      currentContext.read<ParkingController>().setLoading(true);
      await data();
    } on FirebaseException catch (e) {
      cAlertDialog(context: currentContext, message: '${e.message}');
      rethrow;
    } catch (e) {
      printLog(e);
      rethrow;
    } finally {
      currentContext.read<AuthController>().setLoading(false);
      currentContext.read<ParkingController>().setLoading(false);
    }
  }
}
