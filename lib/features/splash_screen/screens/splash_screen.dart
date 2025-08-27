import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gail_india/utils/constants/sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../controllers/splash_controller.dart';

class SplashGate extends StatefulWidget {
  const SplashGate({super.key});

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start once
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.go('/login');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final SplashController splashController = SplashController();
    // splashController.startSplashTimer(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // key part
          children: [
            // Top empty space
            const SizedBox(height: 40),

            // Center content (CNG tanker + Loader)
            Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/vehicle/cng_tanker.png',
                    width: 300,
                    height: 300,
                  ),
                ),
                // const SizedBox(height: 20),
                // Lottie.asset(
                //   'assets/lottie/loading_dots.json',
                //   width: 100,
                //   height: 100,
                // ),
              ],
            ),

            // Bottom content (Logo + Texts)
            Padding(
              padding: const EdgeInsets.only(bottom: 40), // move away from edge
              child: Column(
                children: [
                  Image.asset('assets/logos/GAIL.png', width: 100, height: 100),
                  const SizedBox(height: 10),
                  Text(
                    'Delivering Natural Gas',
                    style: TextStyle(
                      fontSize: Gsizes.fontLg,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Round the Clock,',
                    style: TextStyle(
                      fontSize: Gsizes.fontLg,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Across the Nation',
                    style: TextStyle(
                      fontSize: Gsizes.fontLg,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
