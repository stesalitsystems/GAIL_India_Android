import 'package:flutter/material.dart';
import 'package:gail_india/common/routes/routes.dart';
import 'package:gail_india/utils/theme/Theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gail India',
      themeMode: ThemeMode.light,
      theme: GAppTheme.lightTheme,

      // darkTheme: GAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
