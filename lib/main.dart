// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gail_india/auth/data/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AppRoot()));
}

// import 'package:flutter/material.dart';
// import 'package:gail_india/common/router/router.dart';
// import 'package:gail_india/utils/theme/Theme.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Gail India',
//       themeMode: ThemeMode.light,
//       theme: GAppTheme.lightTheme,
//       // darkTheme: GAppTheme.darkTheme,
//       debugShowCheckedModeBanner: false,
//       initialRoute: AppRoutes.splash,
//       onGenerateRoute: AppRoutes.generateRoute,
//     );
//   }
// }
