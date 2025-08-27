import 'package:flutter/material.dart';

class DashDriver extends StatelessWidget {
  const DashDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Driver Dashboard')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(child: ListTile(title: Text('Cards & sections go here'))),
        ],
      ),
    );
  }
}
