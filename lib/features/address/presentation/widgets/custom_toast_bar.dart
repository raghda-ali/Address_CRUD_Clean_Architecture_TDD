import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

Future<void> showToastBar(
  BuildContext context,
  String message,
) {
  return Future.delayed(Duration.zero, () async {
    showToast(
      message,
      context: context,
      animation: StyledToastAnimation.slideFromBottomFade,
      reverseAnimation: StyledToastAnimation.slideToBottomFade,
      startOffset: const Offset(0.0, 3.0),
      reverseEndOffset: const Offset(0.0, 3.0),
      position: StyledToastPosition.bottom,
      fullWidth: true,
      duration: const Duration(seconds: 4),
      animDuration: const Duration(milliseconds: 400),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn,
      backgroundColor: Colors.deepOrangeAccent,
      textStyle: const TextStyle(color: Colors.white),
      borderRadius: BorderRadius.circular(10),
      isHideKeyboard: true,
    );
  });
}
