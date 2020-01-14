



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
    //可以获得父view所给的最大空间
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
                //value 的值在0.0-2 * pi 变动，
                //CurvePainter 会根据value + offset和 Y进行重绘，
                //在CurvePainter中,通过这个Y 生成了贝塞尔曲线的起始点、结束点和控制点
                //整个变动中会造成上方移动的曲线效果
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
















