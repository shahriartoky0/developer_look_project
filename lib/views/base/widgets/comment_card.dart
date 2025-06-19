import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';
import '../../../utilities/app_icons.dart';
import '../components/custom_cached_image.dart';
import '../components/custom_svg_image.dart';

class CommentCard extends StatelessWidget {
  final String commenterName;
  final String commenterImage;

  final String time;

  final String upvote;

  final String commentDescription;

  final VoidCallback upvoteTap;

  final VoidCallback replyTap;

  const CommentCard({
    super.key,
    required this.textTheme,
    required this.commenterName,
    required this.time,
    required this.upvote,
    required this.commentDescription,
    required this.upvoteTap,
    required this.replyTap,
    required this.commenterImage,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.secondaryColor,
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomCachedImage(height: 30, width: 30, imageUrl: commenterImage),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(commenterName, style: textTheme.displayLarge),
                Text(
                  '$upvote Upvotes',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ],
            ),
            subtitle: Text('3 min ago', style: textTheme.labelSmall?.copyWith(fontSize: 11)),
          ),
          const SizedBox(height: 8),
          Text(commentDescription),
          const SizedBox(height: 8),
          Row(
            spacing: 12,
            children: <Widget>[
              InkWell(
                onTap: upvoteTap,
                child: Row(
                  children: <Widget>[
                    Row(
                      spacing: 3,
                      children: <Widget>[
                        CustomSvgImage(assetName: AppIcons.upvoteIcon),
                        const Text('Upvote'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: replyTap,
                child: Row(
                  children: <Widget>[
                    Row(
                      spacing: 3,
                      children: <Widget>[
                        CustomSvgImage(assetName: AppIcons.replyIcon),
                        const Text('Reply'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}