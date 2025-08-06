import 'package:flutter/material.dart';

class MsAdminDashbaord extends StatelessWidget {
  const MsAdminDashbaord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MS Admin Dashboard')),
      body: Center(child: Text('Welcome to the MS Admin Dashboard!')),
    );
  }
}
