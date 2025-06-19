import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';
import '../../../utilities/app_icons.dart';
import '../components/custom_cached_image.dart';
import '../components/custom_svg_image.dart';

class CommentWidget extends StatelessWidget {
  final VoidCallback sendIconTap;
  final String userImage;

  const CommentWidget({super.key, required this.sendIconTap, required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: CustomCachedImage(imageUrl: userImage),
        ),
        Expanded(
          child: TextFormField(
            // controller: widget.controller,
            decoration: InputDecoration(
              fillColor: AppColors.secondaryColor,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(
                  color: Colors.transparent, // Apply the primary color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(
                  color: Colors.transparent, // Apply the primary color
                ),
              ),

              hintText: 'Write Your comment',
              hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),

              suffixIcon: InkWell(
                onTap: sendIconTap,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomSvgImage(assetName: AppIcons.sendIcon),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            validator: (String? value) {},
          ),
        ),
        const SizedBox(width: 3),
      ],
    );
  }
}
