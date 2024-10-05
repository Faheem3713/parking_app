import 'package:flutter/material.dart';

import 'package:parking/controllers/parking_controller.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Consumer<ParkingController>(builder: (context, value, _) {
        return !value.isLoading && value.history.isEmpty
            ? const Center(
                child: Text('No history found'),
              )
            : ListView.builder(
                itemCount: value.history.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = value.history[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    elevation: 4,
                    child: ListTile(
                      leading:
                          const Icon(Icons.local_parking, color: Colors.blue),
                      title: Text('Reservation ID: ${item.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Time Spent: ${item.timeSpend} minutes'),
                          Text('Fees Paid: \$${item.feesPaid}'),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
              );
      }),
    );
  }
}
