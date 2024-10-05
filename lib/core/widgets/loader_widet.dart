import 'package:flutter/material.dart';
import 'package:parking/controllers/auth_controller.dart';
import 'package:parking/controllers/parking_controller.dart';
import 'package:provider/provider.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key, required this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (child != null) child!,
        Consumer2<AuthController, ParkingController>(
            builder: (context, auth, parking, child) {
          if (parking.isLoading) {
            return ColoredBox(
              color: Colors.black.withOpacity(0.2),
              child: const Center(
                child: RefreshProgressIndicator(),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        })
      ],
    );
  }
}
