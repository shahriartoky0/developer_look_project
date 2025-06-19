import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';

class ScrollableChips extends StatelessWidget {
  const ScrollableChips({super.key, required this.chipLabels});

  final List<String> chipLabels;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          chipLabels.length,
          (int index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Chip(
              backgroundColor: AppColors.secondaryColor,
              label: Text(chipLabels[index], style: Theme.of(context).textTheme.headlineMedium),
            ),
          ),
        ),
      ),
    );
  }
}
