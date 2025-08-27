import 'package:flutter/material.dart';

class DashMsAdmin extends StatelessWidget {
  const DashMsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MS Dashboard')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(child: ListTile(title: Text('Cards & sections go here'))),
        ],
      ),
    );
  }
}
