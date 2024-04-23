import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game/models/obstacle.dart';

class Player extends SpriteComponent with CollisionCallbacks {
  Sprite playerSprite;

  final VoidCallback damage;

  Player({
    required this.playerSprite,
    required position,
    required this.damage,
  }) : super(
          position: position,
          size: Vector2.all(48),
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    sprite = playerSprite;

    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Obstacle) {
      damage.call();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
