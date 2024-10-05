import 'package:flutter/foundation.dart';
import 'package:parking/core/helpers/error_helper.dart'; // Assuming this handles errors and loading states
import 'package:parking/core/helpers/logger.dart';
import 'package:parking/models/history_model.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/services/parking_services.dart';

class ParkingController extends ChangeNotifier {
  bool isLoading = false;
  final List<HistoryModel> history = [];
  final ParkingServices _parkingServices = ParkingServices();

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> manageSlots(int numberOfSlots) async {
    await ErrorHelper.handleError(_parkingServices.manageSlots(numberOfSlots));
  }

  Future<void> bookSlot(Parking data) async {
    await ErrorHelper.handleError(_parkingServices.bookSlot(data));
  }

  Future<void> getHistory(String id) async {
    await ErrorHelper.handleError(() async {
      final data = await _parkingServices.getHistoryById(id);
      history
        ..clear()
        ..addAll(data);
    });
  }

  Future<void> deleteSlot(Parking data, HistoryModel historyData) async {
    await ErrorHelper.handleError(() async {
      Future.wait([
        _parkingServices.deleteSlot(data),
        _parkingServices.saveHistory(historyData)
      ]);
    });
  }

  Stream<List<Parking>> getData() async* {
    try {
      await for (final data in _parkingServices.getData()) {
        yield data;
      }
    } catch (e) {
      printLog(e);
    }
  }
}
