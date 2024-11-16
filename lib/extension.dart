import 'package:flutter/material.dart';

extension CustomizeSize on Size {
  Size resizeWith(double ratio) {
    return Size(width * ratio, height * ratio);
  }
}
