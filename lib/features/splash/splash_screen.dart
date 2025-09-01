import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gail_india/utils/constants/sizes.dart';
import 'package:go_router/go_router.dart';

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
    _timer = Timer(const Duration(seconds: 2), () {
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),
            Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/vehicle/tanker1.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
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
