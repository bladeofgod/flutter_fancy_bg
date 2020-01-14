



import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AnimatedWave extends StatelessWidget{

  final double height; //wave's height
  final double speed; // duration
  final double offset; // the different wave's start X'point


  AnimatedWave({@required this.height,@required this.speed,this.offset = 0.0});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx,constraints){
        return Container(
          height: height,
          width: constraints.biggest.width,
          child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000/speed).round()),
            tween: Tween(begin: 0.0,end: 2 * pi),
            builder: (ctx,value){
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            },
          ),
        );
      },
    );
  }

}


class CurvePainter extends CustomPainter{
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();


    final y1 = sin(value);
    final y2 = sin(value + pi/2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5+0.4 * y1);
    final controlPointY = size.height * (0.5+0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);
    
    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(size.width * 0.5, controlPointY, size.width,
        endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }



}
















