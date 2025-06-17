import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';

class AppTextUnderline extends StatelessWidget {
  const AppTextUnderline({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      child: Divider(thickness: 8, color: AppColors.primaryColor, height: 12),
    );
  }
}
