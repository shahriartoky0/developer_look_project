import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';
  


class CustomToast {
  static final CustomToast _instance = CustomToast._internal();

  factory CustomToast() => _instance;

  CustomToast._internal();

  OverlayEntry? _overlayEntry;

  void showToast({
    required BuildContext context,
    required String message,
    double width = double.infinity, // Use double.infinity for full width
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(horizontal: 50.0),
    Duration duration = const Duration(seconds: 1),
    bool isError = false,
    Color? customBackgroundColor,
    double fontSize = 15,
    Widget? headingWidget,
    ToastPosition position = ToastPosition.bottom,
  }) {
    _overlayEntry?.remove(); // Remove any existing toast
    _overlayEntry = OverlayEntry(
      builder: (context) {
        double? top, bottom;
        switch (position) {
          case ToastPosition.top:
            top = 50.0;
            bottom = null;
            break;
          case ToastPosition.center:
            top = MediaQuery.of(context).size.height / 2 - 50.0;
            bottom = null;
            break;
          case ToastPosition.bottom:
            top = null;
            bottom = 50.0;
            break;
        }

        // Determine the background color
        final backgroundColor = customBackgroundColor ??
            (isError ? Colors.red : AppColors.primaryColor);

        return Positioned(
          top: top,
          bottom: bottom,
          left: 0.0,
          right: 0.0,
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: width),
              // Constrain width
              margin: margin,
              padding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (headingWidget != null) ...[
                    headingWidget,
                    SizedBox(width: 8), // Add spacing between widget and text
                  ],
                  Flexible(
                    child: Text(
                      message,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: fontSize),
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis, // Handle overflow
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    final overlay = Overlay.of(context);
    overlay.insert(_overlayEntry!);

    Future.delayed(duration, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}

enum ToastPosition {
  top,
  center,
  bottom,
}
