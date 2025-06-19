import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/post_card_controller.dart';
import '../../screens/feed/home_page.dart';
import '../components/custom_cached_image.dart';

class PostMakerDetails extends StatelessWidget {
  const PostMakerDetails({
    super.key,
    required this.textTheme,
    required this.imageUrl,
    required this.postMakerName,
    required this.time,
  });

  final TextTheme textTheme;
  final String imageUrl;

  final String postMakerName;

  final String time;

  @override
  Widget build(BuildContext context) {
    final CardController cardController = Get.find<CardController>();

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: CustomCachedImage(imageUrl: imageUrl),
      ),
      title: Text(postMakerName, style: textTheme.displayLarge),
      subtitle: Text(time, style: textTheme.labelSmall),
      trailing: Wrap(
        spacing: 10,
        children: <Widget>[
          /// The rating bar ============ >
          RatingBar(
            initialRating: 3,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 18,
            ratingWidget: RatingWidget(
              full: const Icon(Icons.star, color: Colors.amber),
              empty: const Icon(Icons.star_border),
              half: const Icon(Icons.star_border),
            ),
            itemPadding: EdgeInsets.zero,
            onRatingUpdate: (double rating) {
              cardController.updatedRating.value = rating;
              print(rating);
            },
          ),
          Obx(() => Text(cardController.updatedRating.value.toString())),
        ],
      ),
    );
  }
}