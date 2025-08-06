import 'package:flutter/material.dart';
import 'package:gail_india/utils/constants/colors.dart';

class tripHistoryButton extends StatelessWidget {
  const tripHistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: GColors.primary,
          side: BorderSide.none,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/tripHistory');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Trip History", style: TextStyle(color: Colors.black)),
            SizedBox(width: 4),
            Icon(Icons.history, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
