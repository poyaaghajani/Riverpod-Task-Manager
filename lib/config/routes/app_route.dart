import 'package:flutter/material.dart';

extension Push on BuildContext {
  push(Widget widget) {
    return Navigator.of(this).push(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ));
  }
}

extension PushAndRemoveUntil on BuildContext {
  pushAndRemoveUntil(Widget widget) {
    return Navigator.of(this).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ), (route) => false);
  }
}
