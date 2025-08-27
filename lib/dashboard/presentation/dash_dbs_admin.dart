import 'package:flutter/material.dart';

class DashDbsAdmin extends StatelessWidget {
  const DashDbsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dbs Admin Dashboard')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(child: ListTile(title: Text('Cards & sections go here'))),
        ],
      ),
    );
  }
}
