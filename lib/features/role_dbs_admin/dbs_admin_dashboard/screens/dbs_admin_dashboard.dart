import 'package:flutter/material.dart';

class DbsAdminDashboard extends StatelessWidget {
  const DbsAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DBS Admin Dashboard')),
      body: Center(child: Text('Welcome to the DBS Admin Dashboard!')),
    );
  }
}
