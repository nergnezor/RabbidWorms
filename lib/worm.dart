import 'dart:math';
import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';

class Worm extends BodyComponent with ContactCallbacks {
  static const double wormRadius = 100.5;
  static const double wormDensity = 10.0;
  static const double wormFriction = 0.2;
  static const double wormRestitution = 0.2;

  // Worm(Vector2 position) {
  //   final shape = CircleShape()..radius = wormRadius;
  //   final fixtureDef = FixtureDef(shape)
  //     ..density = wormDensity
  //     ..friction = wormFriction
  //     ..restitution = wormRestitution;
  //   final bodyDef = BodyDef()
  //     ..position = position
  //     ..type = BodyType.dynamic;
  //   // body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  //   // body = world.createBody(bodyDef)..createFixture(fixtureDef);
  //   body.bodyType = BodyType.dynamic;
  // }
  late Vector2 position;

  Worm(Vector2 position) : super() {
    this.position = position;
  }
  //

  @override
  Body createBody() {
    final shape = CircleShape()..radius = wormRadius;
    final fixtureDef = FixtureDef(shape);
    // ..density = wormDensity
    // ..friction = wormFriction
    // ..restitution = wormRestitution;
    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.dynamic;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderCircle(Canvas canvas, Offset position, double radius) {
    super.renderCircle(canvas, position, radius);
    final paint = Paint()
      ..color = const Color(0xFFFF0000)
      ..style = PaintingStyle.stroke;
    // canvas.drawCircle(position, radius, paint);
    const bodyCount = 5;
    for (var i = 0; i < bodyCount; i++) {
      final r = radius * i / bodyCount;
      final angle = i;
      final x = position.dx + r * cos(angle) / (1 + i / 10);
      final y = position.dy + r * sin(angle) / (1 + i / 10);
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    final velocity = body.linearVelocity;
    final speed = velocity.length;
    if (speed > 5) {
      body.linearVelocity = velocity.normalized() * 5;
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is! Worm) {
      return;
    }
    final otherWorm = other as Worm;
    if (body == otherWorm.body) {
      return;
    }
    final position = body.position;
    final otherPosition = otherWorm.body.position;
    final direction = otherPosition - position;
    final force = direction.normalized() * 1000;
    body.applyForce(force);
  }
}
