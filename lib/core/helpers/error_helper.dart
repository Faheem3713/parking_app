import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking/controllers/auth_controller.dart';
import 'package:parking/controllers/parking_controller.dart';
import 'package:parking/core/helpers/alert_dialog.dart';
import 'package:parking/core/helpers/logger.dart';
import 'package:parking/core/helpers/ui_helpers.dart';
import 'package:provider/provider.dart';

class ErrorHelper {
  static Future<void> handleError(dynamic authTask) async {
    try {
      currentContext.read<ParkingController>().setLoading(true);
      if (authTask is Function) {
        await authTask();
      } else {
        authTask;
      }
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
