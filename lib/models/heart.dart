import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class LifeHeart extends SpriteComponent with CollisionCallbacks {
  Sprite playerSprite;

  LifeHeart({
    required this.playerSprite,
    required position,
  }) : super(
    position: position,
    size: Vector2.all(24),
    anchor: Anchor.topLeft,
  );

  @override
  Future<void> onLoad() async {
    sprite = playerSprite;

    return super.onLoad();
  }
}