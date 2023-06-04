import 'package:flutter/material.dart';



class WavePainter extends CustomPainter {
  late double loc;
  late double s;
  late double _l;
  late double _startingLoc;
  late double _itemsLength;
  Color color;
  TextDirection textDirection;

  WavePainter(
      double startingLoc, int itemsLength, this.color, this.textDirection) {
    _startingLoc = startingLoc;
    _itemsLength = itemsLength.toDouble();
    final span = 1.0 / itemsLength;
    s = 0.2;
    double l = startingLoc + (span - s) / 2;
    _l = l;

    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {

    double bendWidth = -10;
    double bezierWidth = 30 + 30;


    double startOfBendNew = (_startingLoc * size.width) - (bendWidth/2);
    double startOfBezierNew = startOfBendNew - bezierWidth;
    double endOfBendNew = ((_startingLoc * size.width)+(size.width / _itemsLength)) + (bendWidth/2);
    double endOfBezierNew = endOfBendNew + (bezierWidth);
    double centrePoint = startOfBezierNew + ((endOfBezierNew - startOfBezierNew)/2);
    double leftControlPoint1 = startOfBendNew;
    double leftControlPoint2 = startOfBendNew;
    double rightControlPoint1 = endOfBendNew;
    double rightControlPoint2 = endOfBendNew;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(startOfBezierNew, size.height)
      ..cubicTo(
        leftControlPoint1,
        size.height,
        leftControlPoint2,
        0,
        centrePoint,
        0,
      )
      ..cubicTo(
        rightControlPoint1,
        0,
        rightControlPoint2,
        size.height,
        endOfBezierNew,
        size.height,
      )
      ..lineTo(startOfBezierNew, size.height)

      ..close();


    double endOfBendStartPath = ((size.width / _itemsLength)) + (bendWidth/2);
    double endOfBezierStartPath = endOfBendNew + (bezierWidth);


    final startPath = Path()
      ..moveTo(0, 0)
      ..lineTo(((size.width / _itemsLength) *0.6), 0)
      ..cubicTo(
        endOfBendStartPath,
        0,
        endOfBendStartPath,
        size.height,
        endOfBezierStartPath,
        size.height,
      )
      ..lineTo(((size.width / _itemsLength) *0.75), size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();





    final endPath = Path()
      ..moveTo(startOfBezierNew, size.height)
      ..cubicTo(
        leftControlPoint1,
        size.height,
        leftControlPoint2,
        0,
        centrePoint,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    if(_startingLoc <= 0.0){

      canvas.drawPath(startPath, paint);
    }else if(_l >= 0.7){
      canvas.drawPath(endPath, paint);
    }else{
      canvas.drawPath(path, paint);
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
