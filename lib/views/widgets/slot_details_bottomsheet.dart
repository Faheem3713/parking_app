import 'package:flutter/material.dart';
import 'package:parking/controllers/auth_controller.dart';
import 'package:parking/controllers/parking_controller.dart';
import 'package:parking/core/helpers/alert_dialog.dart';
import 'package:parking/core/helpers/gap.dart';
import 'package:parking/core/widgets/bottom_sheet.dart';
import 'package:parking/models/parking_model.dart';
import 'package:provider/provider.dart';

Future<void> slotDetailsBottomsheet(BuildContext context, int slotNo) async {
  final user = context.read<AuthController>().userData;
  cShowModalBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Parking Fee Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const VGap(16),
            const Text(
              'Up to 10 min: Free\n'
              'After 10 min: \$100/Hour',
              style: TextStyle(fontSize: 16),
            ),
            const VGap(24),
            ElevatedButton(
              onPressed: () async {
                await context.read<ParkingController>().bookSlot(Parking(
                    id: user.id,
                    isBooked: true,
                    name: user.name,
                    slotNo: slotNo,
                    time: DateTime.now()));
                if (context.mounted) {
                  await cAlertDialog(
                      context: context, message: 'Successfully booked');
                  Navigator.pop(context);
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ));
}
