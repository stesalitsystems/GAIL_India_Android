import 'package:flutter/material.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = SplashController();
    splashController.startSplashTimer(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
          ), // Adjust for AppBar height
          Center(
            child: Image.asset(
              'assets/logos/GAIL.png', // Ensure this path matches your asset structure
              width: 150, // Adjust size as needed
              height: 150,
            ),
          ),
          Text(
            'Gas Authority of India Ltd.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Fleet Management System.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              SizedBox(height: 4),
              Text(
                '© 2025 Gail India Limited',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
