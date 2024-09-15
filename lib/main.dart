import 'package:flutter/material.dart';
import 'package:todooapp/ui/screens/home/HomeScreen.dart';
import 'package:todooapp/ui/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routes: {
        Home.RouteName:(_)=>const Home(),
      },
      initialRoute: Home.RouteName,
    );
  }
}

