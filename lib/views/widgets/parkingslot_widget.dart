import 'package:flutter/material.dart';
import 'package:parking/services/parking_services.dart';
import 'package:parking/views/widgets/reserved_details_bottomsheet.dart';
import 'package:parking/views/widgets/slot_details_bottomsheet.dart';

class ParkingSlotsWidget extends StatelessWidget {
  const ParkingSlotsWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ParkingServices().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final data = snapshot.data![index];
                  return GestureDetector(
                    onTap: () async {
                      data.isBooked ?? false
                          ? showReservationDetailsBottomSheet(context, data)
                          : slotDetailsBottomsheet(context, index);
                    },
                    child: Card(
                      elevation: 2,
                      color: data.isBooked ?? false
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      child: Center(
                        child: Text(
                          'Slot ${index + 1}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: snapshot.data?.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            );
          } else {
            return const SliverToBoxAdapter(child: SizedBox());
          }
        });
  }
}
