import 'package:flutter/material.dart';
import 'package:flutter_game/screens/game_screen.dart';
import 'package:flutter_game/screens/main_screen.dart';

void main() {
  runApp(const PlayMeApp());
}

class PlayMeApp extends StatelessWidget {
  const PlayMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play Me',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        primaryColor: Colors.orangeAccent,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        GameScreen.routeName: (context) => const GameScreen(),
      },
    );
  }
}
