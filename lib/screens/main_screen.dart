import 'package:flutter/material.dart';
import 'package:flutter_game/common/constant/sizes.dart';
import 'package:flutter_game/screens/game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/racing_main.png',
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(0.8),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Flutter Racer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    GameScreen.routeName,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Sizes.size4,
                    ),
                    side: const BorderSide(
                      color: Colors.black87,
                    ),
                  ),
                ),
                child: const Text(
                  'START',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size32,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
