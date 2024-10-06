// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/controllers/auth_controller.dart';
import 'package:parking/controllers/parking_controller.dart';
import 'package:parking/core/helpers/routing_helper.dart';
import 'package:parking/core/widgets/alert_dialog.dart';
import 'package:parking/core/widgets/gap.dart';
import 'package:parking/core/widgets/bottom_sheet.dart';
import 'package:parking/views/history_screen.dart';
import 'package:parking/views/login_screen.dart';
import 'package:parking/views/widgets/parkingslot_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthController>().userData;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Parking Dashboard'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => _logOut(context),
                ),
              ],
              floating: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Welcome, ${user.name}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  context.read<ParkingController>().getHistory(user.id!);
                  context.push(const HistoryScreen());
                },
                child: const Text('View Full History'),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                  onPressed: () {
                    final slotController = TextEditingController();
                    cShowModalBottomSheet(
                        context: context,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: slotController,
                                decoration: const InputDecoration(
                                  labelText: 'Number of slots',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              const VGap(20),
                              ElevatedButton(
                                onPressed: () async {
                                  await context
                                      .read<ParkingController>()
                                      .manageSlots(
                                          int.tryParse(slotController.text) ??
                                              0);
                                  context.pop();
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          ),
                        ));
                  },
                  child: const Text('Manage Slots'),
                ),
              ),
            ),
            const ParkingSlotsWidget(),
          ],
        ),
      ),
    );
  }

  void _logOut(BuildContext context) {
    cAlertDialog(
      context: context,
      message: 'Are you sure you want to log out?',
      action: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                context.pushAndRemoveUntil(const LoginScreen());
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('No'),
            ),
          ],
        ),
      ],
    );
  }
}
