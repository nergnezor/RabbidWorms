import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const GameWidget.controlled(gameFactory: MouseJointExample.new));
}

class MouseJointExample extends Forge2DGame {
  MouseJointExample()
      : super(world: MouseJointWorld(), gravity: Vector2(0, 80));
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
  TextComponent debugText =
      TextComponent(text: "debug", position: Vector2(0, 40));

  static const double gameSize = 18;
  static double timeFactor = 1;

  @override
  Future<void> onLoad() async {
    game.camera.viewfinder.visibleGameSize = Vector2.all(gameSize);
    super.onLoad();
    // game.camera.viewport.add(FpsTextComponent());

    program = await FragmentProgram.fromAsset('shaders/bg.frag');
    shader = program.fragmentShader();
    // if not web
    if (!kIsWeb) {
      // FlameAudio.bgm.play('megalergik.mp3');
      playingMusic = true;
    }
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
    // Draw background gradient
    canvas.drawColor(Color.fromARGB(255, 40, 24, 60), BlendMode.srcOver);
    shader
      ..setFloat(0, time * 0.1)
      ..setFloat(1, game.size.x / 300)
      ..setFloat(2, game.size.y / 300);
    final canvasRect = canvas.getLocalClipBounds();
    canvas.drawRect(canvasRect, Paint()..shader = shader);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    time += dt;
    debugText.text = game.world.children.length.toString();
    super.update(dt);
  }
}
