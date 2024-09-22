import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'boundaries.dart';
import 'worm.dart';

void main() {
  runApp(const GameWidget.controlled(gameFactory: MouseJointExample.new));
}

class MouseJointExample extends Forge2DGame {
  MouseJointExample()
      : super(world: MouseJointWorld(), gravity: Vector2(0, 10000));
}

class MouseJointWorld extends Forge2DWorld
    with DragCallbacks, HasGameReference<Forge2DGame> {
  late final FragmentProgram program;
  late final FragmentShader shader;
  bool playingMusic = false;
  double time = 0;
  PositionComponent camera = PositionComponent();
  TextComponent lifeText =
      TextComponent(text: "100", position: Vector2(30, 20));

  Worm worm = Worm(Vector2(0, 0));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // game.camera.viewfinder.visibleGameSize = Vector2.all(gameSize);
    game.camera.viewport.add(FpsTextComponent());
    game.camera.viewport.add(lifeText);

    program = await FragmentProgram.fromAsset('shaders/bg.frag');
    shader = program.fragmentShader();
    // if not web
    if (!kIsWeb) {
      // FlameAudio.bgm.play('megalergik.mp3');
      playingMusic = true;
    }

    // Add boundaries
    // addAll(createBoundaries(game));
    final boundaries = createBoundaries(game);
    game.addAll(boundaries);
    worm = Worm(Vector2(game.size.x / 2, 0));
    game.add(worm);
    // game.add(Worm(Vector2(game.size.x / 2, 0)));
  }

  @override
  void onDragStart(DragStartEvent info) {
    super.onDragStart(info);
  }

  @override
  void onDragUpdate(DragUpdateEvent info) {}

  @override
  void onDragEnd(DragEndEvent info) {
    super.onDragEnd(info);
  }

  @override
  void render(Canvas canvas) {
    final gameSize = game.size;
    // Draw background gradient
    shader
      ..setFloat(0, time)
      ..setFloat(1, gameSize.x)
      ..setFloat(2, gameSize.y);
    // final canvasRect = canvas.getLocalClipBounds();
    // final canvasRect = Rect.fromLTWH(0, 0, game.size.x, game.size.y);
    final canvasRect = game.size.toRect();
    canvas.drawRect(canvasRect, Paint()..shader = shader);

    super.render(canvas);
  }

  @override
  void update(double dt) {
    time += dt;
    super.update(dt);
  }
}
