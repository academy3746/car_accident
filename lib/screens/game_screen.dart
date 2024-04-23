import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/screens/racing_game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  static const String routeName = '/game';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: RacingGame(),
      ),
    );
  }
}
