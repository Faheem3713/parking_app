import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking/controllers/auth_controller.dart';
import 'package:parking/controllers/parking_controller.dart';
import 'package:parking/core/helpers/alert_dialog.dart';
import 'package:parking/core/helpers/gap.dart';
import 'package:parking/core/helpers/logger.dart';
import 'package:parking/core/widgets/bottom_sheet.dart';
import 'package:parking/models/history_model.dart';
import 'package:parking/models/parking_model.dart';
import 'package:provider/provider.dart';

void showReservationDetailsBottomSheet(BuildContext context, Parking parking) {
  final String parkingTime = DateFormat('hh:mm a').format(parking.time!);
  final user = context.read<AuthController>().userData;
  cShowModalBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Reservation Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const VGap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Name :', style: TextStyle(fontSize: 16)),
                Text(parking.name ?? '', style: const TextStyle(fontSize: 16)),
              ],
            ),
            const VGap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Entry Time:', style: TextStyle(fontSize: 16)),
                Text(parkingTime, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const VGap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Slot Number:', style: TextStyle(fontSize: 16)),
                Text((parking.slotNo! + 1).toString(),
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const VGap(24),
            if (user.id == parking.id)
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    await _calculateAndShowParkingFee(context, parking);
                    printLog('adsfas');
                  } catch (e) {
                    printLog(e);
                    rethrow;
                  }
                },
                child: const Text('Exit'),
              ),
          ],
        ),
      ));
}

Future<void> _calculateAndShowParkingFee(
    BuildContext context, Parking parking) async {
  final DateTime currentTime = DateTime.now();
  final Duration timeSpent = currentTime.difference(parking.time!);
  final int totalMinutes = timeSpent.inMinutes;

  double fee = 0;
  if (totalMinutes > 10) {
    int hours = (totalMinutes / 60).ceil();
    fee = hours * 100;
  }
  cShowModalBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Parking Fee',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const VGap(16),
            Text('Time Spent: $totalMinutes minutes',
                style: const TextStyle(fontSize: 16)),
            const VGap(8),
            Text('Total Fee: \$${fee.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16)),
            const VGap(24),
            ElevatedButton(
              onPressed: () async {
                final history = HistoryModel(
                    name: parking.name,
                    id: context.read<AuthController>().userData.id,
                    feesPaid: fee.toStringAsFixed(2),
                    timeSpend: totalMinutes.toString());
                await context
                    .read<ParkingController>()
                    .deleteSlot(parking, history);
                await cAlertDialog(
                    context: context, message: 'Paid Successfully');
                Navigator.pop(context);
              },
              child: const Text('Pay and Exit'),
            ),
          ],
        ),
      ));
}
