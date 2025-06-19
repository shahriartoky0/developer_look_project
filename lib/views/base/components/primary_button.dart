import 'package:developper_look/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final num width;
  final MainAxisAlignment mainAxisAlignment;
  final Widget iconWidget;
  final double height;
  final double radius;
  final TextStyle? buttonTextStyle;

  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.width = double.infinity,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.iconWidget = const SizedBox(),
    this.height = 50,
    this.buttonTextStyle,
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: width.toDouble(),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(24),
    //     // boxShadow:   <BoxShadow>[
    //     //   BoxShadow(
    //     //     color: Colors.black.withValues(alpha: 0.7),
    //     //     // Blue shadow with opacity
    //     //     offset: Offset(0, 6),
    //     //   ),
    //     // ],
    //   ),
    //   child: ElevatedButton(
    //
    //     onPressed: onPressed,
    //     style: ElevatedButton.styleFrom(backgroundColor: AppColors.black),
    //     child: Text(buttonText, style: Theme.of(context).textTheme.labelMedium),
    //   ),
    // );
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width.toDouble(),
        height: height,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Text(buttonText, style: buttonTextStyle ?? Theme.of(context).textTheme.labelMedium),
            iconWidget,
          ],
        ),
      ),
    );
  }
}
