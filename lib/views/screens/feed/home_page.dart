import 'package:developper_look/utilities/app_colors.dart';
import 'package:developper_look/views/base/components/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class PostCard extends StatelessWidget {
  final String userName;
  final String profileImageUrl;
  final String date;
  final String airline;
  final String flightDetails;
  final String postText;
  final String postImageUrl;
  final int likes;
  final int comments;
  final String commentUserName;
  final String commentText;

  const PostCard({
    required this.userName,
    required this.profileImageUrl,
    required this.date,
    required this.airline,
    required this.flightDetails,
    required this.postText,
    required this.postImageUrl,
    required this.likes,
    required this.comments,
    required this.commentUserName,
    required this.commentText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                  radius: 24,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      '$date • $airline • $flightDetails',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Post Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              postText,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          // Post Image
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Image.network(postImageUrl),
          ),

          // Interaction Section (Likes, Comments)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up_alt_outlined, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '$likes Likes',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.comment_outlined, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '$comments Comments',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Comment Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.account_circle, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        commentUserName,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        commentText,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final CardController cardController = Get.find<CardController>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: CustomCachedImage(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAe9NZZk7nUE_anJir2Scf7tsqMHRdEpCbJg&s',
                  ),
                ),
                title: Text('Dianne Russel', style: textTheme.displayLarge),
                subtitle: Text('1 Day ago', style: textTheme.labelSmall),
                trailing: Wrap(
                  spacing: 10,
                  children: [
                    RatingBar(
                      initialRating: 3,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 18,
                      ratingWidget: RatingWidget(
                        full: Icon(Icons.star, color: Colors.amber),
                        empty: Icon(Icons.star_border),
                        half: Icon(Icons.star_border),
                      ),
                      itemPadding: EdgeInsets.symmetric(horizontal: 0),
                      onRatingUpdate: (double rating) {
                        cardController.updatedRating.value = rating;
                        print(rating);
                      },
                    ),
                    Obx(
                      () => Text(cardController.updatedRating.value.toString()),
                    ),
                  ],
                ),
              ),
              Chip(
                backgroundColor: Colors.grey.withValues(alpha: 0.4),
                label: Text('LHR - DEL', style: textTheme.headlineMedium),
              ),
              SizedBox(height: 12),
              Text(
                'Stay tuned for a ​smoother, more convenient experience right at your fingertips ,  a ​smoother, more convenient  a ​smoother, more convenient other, more convenient experience right at your ',
              ),
              TextButton(
                onPressed: () {},
                child: Text('See more', style: textTheme.displayLarge),
              ),
              CustomCachedImage(
                height: Get.height * 0.3,
                width: double.infinity,

                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAe9NZZk7nUE_anJir2Scf7tsqMHRdEpCbJg&s',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardController extends GetxController {
  final RxDouble updatedRating = 3.0.obs;
}
