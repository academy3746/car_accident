// ignore_for_file: avoid_print

import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_game/common/constant/sizes.dart';
import 'package:flutter_game/models/heart.dart';
import 'package:flutter_game/models/move_button.dart';
import 'package:flutter_game/models/obstacle.dart';
import 'package:flutter_game/models/player.dart';
import 'package:flame/text.dart';

class RacingGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player player;

  late MoveButton left;

  late MoveButton right;

  List<LifeHeart> lifeHeartList = [];

  late Sprite playerSprite;

  late Sprite obstacleSprite;

  late Sprite leftMoveSprite;

  late Sprite rightMoveSprite;

  double nextSpawnSeconds = 0;

  int currentScore = 0;

  late Function onGameOver;

  int playerDirection = 0;

  late TextComponent scoreText;

  @override
  Color backgroundColor() {
    return const Color(0xFFA2A2A2);
  }

  @override
  Future<void> onLoad() async {
    Image playerImg = await images.load('racing_car.png');

    Image obstacleImg = await images.load('barrier.png');

    Image heartImg = await images.load('heart.png');

    Image leftImg = await images.load('left.png');

    Image rightImg = await images.load('right.png');

    playerSprite = Sprite(playerImg);

    obstacleSprite = Sprite(obstacleImg);

    leftMoveSprite = Sprite(leftImg);

    rightMoveSprite = Sprite(rightImg);

    player = Player(
      playerSprite: playerSprite,
      position: Vector2(
        size.x * 0.25,
        size.y - 20,
      ),
      damage: onDamage,
    );

    left = MoveButton(
      moveSprite: leftMoveSprite,
      position: Vector2(30, size.y - 80),
      direction: 'left',
      onTapMoveButton: (isTapping) {
        if (isTapping) {
          playerDirection = -1;
        } else {
          playerDirection = 0;
        }
      },
    );

    right = MoveButton(
      moveSprite: rightMoveSprite,
      position: Vector2(size.x - 30, size.y - 80),
      direction: 'left',
      onTapMoveButton: (isTapping) {
        if (isTapping) {
          playerDirection = 1;
        } else {
          playerDirection = 0;
        }
      },
    );

    lifeHeartList.add(
      LifeHeart(
        playerSprite: Sprite(heartImg),
        position: Vector2(
          60,
          60,
        ),
      ),
    );

    scoreText = TextComponent(
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: Sizes.size32,
          color: Color(0xFF000000),
          fontWeight: FontWeight.bold,
        ),
      ),
      anchor: Anchor.topRight,
      position: Vector2(
        size.x - 60,
        50,
      ),
    );

    add(scoreText);

    add(player);

    add(left);

    add(right);

    startBgm();

    for (LifeHeart sex in lifeHeartList) {
      add(sex);
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    nextSpawnSeconds -= dt;

    if (nextSpawnSeconds < 0) {
      add(
        Obstacle(
          obstacleSprite: obstacleSprite,
          position: Vector2(
            size.x * Random().nextDouble() * 1,
            0,
          ),
        ),
      );

      nextSpawnSeconds = 0.3 * Random().nextDouble() * 2;

      if (!paused) {
        currentScore++;

        scoreText.text = currentScore.toString();
      }
    }

    if (playerDirection == 1) {
      player.position = Vector2(
        player.position.x >= size.x - 30
            ? player.position.x
            : player.position.x + 7,
        player.position.y,
      );
    } else if (playerDirection == -1) {
      player.position = Vector2(
        player.position.x <= size.x - 30
            ? player.position.x
            : player.position.x - 7,
        player.position.y,
      );
    } else {
      player.position = Vector2(
        player.position.x,
        player.position.y,
      );
    }
  }

  void onDamage() {
    if (lifeHeartList.isNotEmpty) {
      FlameAudio.play('sfx/car_crash.ogg');

      remove(
        lifeHeartList[lifeHeartList.length - 1],
      );

      lifeHeartList.removeLast();

      return;
    }

    Future.delayed(const Duration(microseconds: 500), () {
      paused = true;
    });
  }

  void startBgm() {
    FlameAudio.bgm.initialize();

    FlameAudio.bgm.play('music/ending.wav');
  }

  void stopBgm() {
    FlameAudio.bgm.initialize();

    FlameAudio.bgm.play('music/level2.wav');
  }

  @override
  void onDispose() {
    stopBgm();

    super.onDispose();
  }
}
