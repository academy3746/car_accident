import 'package:flame/components.dart';
import 'package:flame/events.dart';

class MoveButton extends SpriteComponent with TapCallbacks {
  Sprite moveSprite;

  Function(bool) onTapMoveButton;

  MoveButton({
    required this.moveSprite,
    required position,
    required String direction,
    required this.onTapMoveButton,
  }) : super(
          position: position,
          size: Vector2.all(24),
          anchor: direction == 'left' ? Anchor.bottomLeft : Anchor.bottomRight,
        );

  @override
  Future<void> onLoad() async {
    sprite = moveSprite;

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTapMoveButton.call(true);

    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    onTapMoveButton.call(false);

    super.onTapUp(event);
  }
}
