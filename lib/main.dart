import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todooapp/ui/screens/home/HomeScreen.dart';
import 'package:todooapp/ui/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBKrEPSkn3eQxOzpRocc4HD3NMD9q-qDhs",
      appId: "1:303355207222:android:6a45126d351dcc6efec297",
      messagingSenderId: "todo-49214",
      projectId: "todo-49214"
    ),
  );
  runApp(MyApp());
}

class DefaultFirebaseOptions {
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

