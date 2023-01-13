import 'package:flutter/material.dart';


///Use for get posotion cart
Position getPositionByKey(GlobalKey key) {
  final renderObject = key.currentContext!.findRenderObject()!;
  var translation = renderObject.getTransformTo(null).getTranslation();
  final rect =
      renderObject.paintBounds.shift(Offset(translation.x, translation.y));
  return Position(rect.left, rect.top, rect.size);
}

class Position {
  double x;
  double y;
  Size size;

  Position(this.x, this.y, this.size);
}
