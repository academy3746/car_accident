import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game/models/player.dart';

class Obstacle extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Sprite obstacleSprite;

  Obstacle({
    required this.obstacleSprite,
    required position,
  }) : super(
          position: position,
          size: Vector2.all(64),
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    sprite = obstacleSprite;

    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y = position.y + 5;

    if (position.y - size.y > gameRef.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Player) {
      removeFromParent();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
