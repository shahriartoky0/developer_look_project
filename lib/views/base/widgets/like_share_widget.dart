
import 'package:flutter/material.dart';

import '../../../utilities/app_icons.dart';
import '../components/custom_svg_image.dart';

class LikeShareWidget extends StatelessWidget {
  final VoidCallback onLikeTap;
  final VoidCallback onShareTap;

  const LikeShareWidget({super.key, required this.onLikeTap, required this.onShareTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          spacing: 5,
          children: <Widget>[
            InkWell(
              onTap: onLikeTap,
              child: CustomSvgImage(assetName: AppIcons.likeIcon, height: 24, width: 24),
            ),
            const Text('Like'),
          ],
        ),
        Row(
          spacing: 5,
          children: <Widget>[
            InkWell(
              onTap: onShareTap,
              child: CustomSvgImage(assetName: AppIcons.shareIcon, height: 24, width: 24),
            ),
            const Text('Share'),
          ],
        ),
      ],
    );
  }
}