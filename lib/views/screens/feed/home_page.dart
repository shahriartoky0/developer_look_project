import 'package:developper_look/utilities/app_colors.dart';
import 'package:developper_look/utilities/app_icons.dart';
import 'package:developper_look/views/base/components/custom_cached_image.dart';
import 'package:developper_look/views/base/components/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/post_card_controller.dart';
import '../../base/components/primary_button.dart';
import '../../base/widgets/comment_card.dart';
import '../../base/widgets/comment_widget.dart';
import '../../base/widgets/like_share_widget.dart';
import '../../base/widgets/post_maker_details_widget.dart';
import '../../base/widgets/scrollable_chips_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    // List of chips data
    final List<String> chipLabels = <String>[
      'LHR - DEL',
      'NYC - LA',
      'SFO - MIA',
      'BOS - ORD',
      'SEA - ATL',
    ];
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Appbar section ========== >
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  spacing: 12,
                  children: [
                    Text(
                      'Airline Review',
                      style: textTheme.displayLarge?.copyWith(color: Colors.black, fontSize: 18),
                    ),
                    const Spacer(),
                    CustomSvgImage(assetName: AppIcons.homeNotificationIcon),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),

                        child: const CustomCachedImage(
                          height: 30,
                          width: 30,
                          imageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAe9NZZk7nUE_anJir2Scf7tsqMHRdEpCbJg&s',
                        ),
                      ),
                    ),
                    CustomSvgImage(assetName: AppIcons.homeMenuIcon),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),

                child: CustomCachedImage(
                  width: Get.width * 0.95,
                  height: 80,

                  imageUrl:
                      'https://www.boeing.com/content/theboeingcompany/us/en/commercial/_jcr_content/root/container_2091943792/hero_teaser.coreimg.jpeg/1748637512430/commercial-home-737.jpeg',
                ),
              ),
              const SizedBox(height: 16),

              /// Button section ========== >
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryButton(
                          radius: 12,
                          width: Get.width * .45,
                          iconWidget: CustomSvgImage(assetName: AppIcons.experienceShareIcon),
                          buttonText: 'Share Your Experience  ',
                          onPressed: () {},
                          buttonTextStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                          ),
                        ),
                        PrimaryButton(
                          radius: 12,
                          width: Get.width * .45,
                          iconWidget: CustomSvgImage(assetName: AppIcons.personQuestionIcon),
                          buttonText: 'Ask A Question  ',
                          onPressed: () {},
                          buttonTextStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      width: Get.width * .93,

                      radius: 12,
                      iconWidget: CustomSvgImage(
                        assetName: AppIcons.homeSearchIcon,
                        color: Colors.white,
                      ),
                      buttonText: 'Search  ',
                      onPressed: () {},
                      buttonTextStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // controller: _scrollController,
                // Assign ScrollController here
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ///  ========================> The details of the person who posted  ======>
                        PostMakerDetails(
                          textTheme: textTheme,
                          imageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAe9NZZk7nUE_anJir2Scf7tsqMHRdEpCbJg&s',
                          postMakerName: 'Dianne Russel',
                          time: '1 Day ago',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /// The keyword chips =============>
                              ScrollableChips(chipLabels: chipLabels),
                              const SizedBox(height: 12),
                              const Text(
                                'Stay tuned for a ​smoother, more convenient experience right at your fingertips ,  a ​smoother, more convenient  a ​smoother, more convenient other, more convenient experience right at your ',
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('See more', style: textTheme.displayLarge),
                              ),

                              /// ================================== Image showing =================== >
                              CustomCachedImage(
                                height: Get.height * 0.3,
                                width: double.infinity,

                                imageUrl:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAe9NZZk7nUE_anJir2Scf7tsqMHRdEpCbJg&s',
                              ),
                              const SizedBox(height: 8),

                              ///===============  The like and share count  ================= >
                              Row(
                                spacing: 12,
                                children: <Widget>[
                                  const Text('30 like'),
                                  Container(
                                    height: 3,
                                    width: 3,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Text('20 comment'),
                                ],
                              ),
                              const SizedBox(height: 12),

                              ///===============  The like and share feature Icon ================= >
                              LikeShareWidget(
                                onLikeTap: () {
                                  /// TODO : Like logic ========== >
                                },
                                onShareTap: () {
                                  /// TODO : Share logic ========== >
                                },
                              ),
                              const SizedBox(height: 12),

                              /// =================== Comment card ===================>
                              // now showing only one comment ==== >
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                // controller: _scrollController,
                                // Assign ScrollController here
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  return CommentCard(
                                    textTheme: textTheme,
                                    commenterName: 'Darron Levesque',
                                    time: '3 min ago',
                                    upvote: '4',
                                    commentDescription:
                                        "'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis'",
                                    upvoteTap: () {
                                      /// TODO :  Make upvote logic ========== >
                                    },
                                    replyTap: () {
                                      /// TODO : Make a reply logic ========== >
                                    },
                                    commenterImage:
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAe9NZZk7nUE_anJir2Scf7tsqMHRdEpCbJg&s',
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(height: 8);
                                },
                              ),

                              TextButton(
                                onPressed: () {
                                  Get.find<CardController>().showAllComments.value =
                                      !Get.find<CardController>().showAllComments.value;
                                },
                                child: Text('See more Comments', style: textTheme.displayLarge),
                              ),

                              /// ============== The Comment tile ==========>
                              CommentWidget(
                                sendIconTap: () {
                                  /// TODO : comment logic
                                },
                                userImage:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAe9NZZk7nUE_anJir2Scf7tsqMHRdEpCbJg&s',
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 16);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
