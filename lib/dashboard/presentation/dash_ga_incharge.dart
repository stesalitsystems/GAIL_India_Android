import 'package:flutter/material.dart';

class DashGaIncharge extends StatelessWidget {
  const DashGaIncharge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GA Dashboard')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(child: ListTile(title: Text('Cards & sections go here'))),
        ],
      ),
    );
  }
}
