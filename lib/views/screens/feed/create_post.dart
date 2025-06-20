import 'dart:io';
import 'package:developper_look/controller/post_card_controller.dart';
import 'package:developper_look/model/airport_details.dart';
import 'package:developper_look/utilities/app_constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:developper_look/utilities/app_icons.dart';
import 'package:developper_look/views/base/components/custom_svg_image.dart';
import 'package:developper_look/views/base/components/primary_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../utilities/app_colors.dart';
import '../../base/components/custom_toast.dart';
import '../../base/widgets/custom_search_dropdown.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickImages() async {
    PermissionStatus status;
    if (Platform.isAndroid && (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 33) {
      status = await Permission.photos.request();
    } else {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null) {
        setState(() {
          if (_images.length + pickedFiles.length <= 10) {
            _images.addAll(
              pickedFiles.map((file) {
                print('Selected image path: ${file.path}');
                return File(file.path);
              }),
            );
          } else {
            _images.addAll(
              pickedFiles.take(10 - _images.length).map((file) {
                print('Selected image path: ${file.path}');
                return File(file.path);
              }),
            );
          }
        });
      }
    } else {
      print('Permission denied for accessing photos.');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please grant permission to access photos.')));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextEditingController _dateTEController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 8,
            right: 8,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Share',
                      style: textTheme.displayLarge?.copyWith(color: Colors.black, fontSize: 22),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(CupertinoIcons.clear),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: _pickImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const <double>[8, 2],
                        color: Colors.black.withValues(alpha: 0.4),
                        child: Container(
                          constraints: BoxConstraints(minHeight: Get.height * 0.25),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(56, 78, 183, 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                              _images.isEmpty
                                  ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CustomSvgImage(
                                        assetName: AppIcons.uploadImageIcon,
                                        width: 48,
                                        height: 48,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Browse your images from the device gallery',
                                        style: textTheme.headlineMedium,
                                      ),
                                      Text(
                                        'Maximum 10 Photos',
                                        style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  )
                                  : MasonryGridView.count(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    itemCount: _images.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.file(
                                              _images[index],
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                print('Error loading image: $error');
                                                return const Icon(Icons.error, color: Colors.red);
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _images.removeAt(index);
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => CustomDropdown<AirportDetails>(
                        items: Get.find<CardController>().airports.value,
                        labelText: 'Departure Airport',
                        itemBuilder: (AirportDetails item) {
                          print('Building item: $item');
                          return ListTile(
                            title: Text(item.name ?? ''),
                            subtitle: Text('${item.city}, ${item.country}'),
                            trailing: Text(item.code ?? ''),
                          );
                        },
                        displayString: (AirportDetails item) => item.name ?? '',
                        // Display name in text field
                        onItemSelected: (AirportDetails selectedItem) {
                          print('Selected Item: ${selectedItem.name} (${selectedItem.code})');
                        },
                        scrollController: _scrollController,
                        shouldScroll: false,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomDropdown<AirportDetails>(
                        items: Get.find<CardController>().airports,
                        labelText: 'Arrival Airport',
                        itemBuilder: (AirportDetails airport) {
                          // print('Building item: $airport');
                          return ListTile(
                            title: Text(airport.name ?? ''),
                            subtitle: Text(airport.country ?? ''),
                            trailing: Text(airport.code ?? ''),
                          );
                        },
                        onItemSelected: (AirportDetails selectedItem) {
                          print('Selected Item: ${selectedItem.name} (${selectedItem.code})');
                        },
                        scrollController: _scrollController,
                        shouldScroll: false,
                        displayString: (AirportDetails item) => item.name ?? '',
                      ),

                    const SizedBox(height: 12),
                    CustomDropdown<String>(
                      items: AppConstants.airlineNames,
                      labelText: 'Airline',
                      itemBuilder: (String item) {
                        print('Building item: $item');
                        return ListTile(title: Text(item));
                      },
                      onItemSelected:
                          (String selectedItem) => print('Selected Item: $selectedItem'),
                      scrollController: _scrollController,
                      shouldScroll: true,
                      displayString: (String item) => item,
                    ),
                    const SizedBox(height: 12),
                    CustomDropdown<String>(
                      items: const <String>[
                        'Any',
                        'Business',
                        'First',
                        'Premium Economy',
                        'Economy',
                      ],
                      labelText: 'Class',
                      itemBuilder: (String item) {
                        print('Building item: $item');
                        return ListTile(title: Text(item));
                      },
                      onItemSelected:
                          (String selectedItem) => print('Selected Item: $selectedItem'),
                      scrollController: _scrollController,
                      shouldScroll: true,
                      displayString: (String item) => item,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      minLines: 6,
                      maxLines: 6,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.7)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.7)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.7)),
                        ),
                        hintText: 'Add a description',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _dateTEController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.7)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(color: Colors.transparent),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.7)),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.7)),
                              ),
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                              suffixIcon: InkWell(
                                onTap: () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (selectedDate != null) {
                                    String formattedDate = DateFormat(
                                      'MMMM yyyy',
                                    ).format(selectedDate);
                                    _dateTEController.text = formattedDate;
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.0),
                                  child: CustomSvgImage(assetName: AppIcons.appCalendarIcon),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            const Text('Rating '),
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
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      buttonText: "Post",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Get.back();
                          ToastManager.show(
                            message: "Post Shared",
                            icon: const Icon(Icons.done_all, color: AppColors.white),
                            backgroundColor: AppColors.black,
                            textColor: Colors.white,
                            animationDuration: const Duration(milliseconds: 500),
                            animationCurve: Curves.easeInSine,
                            duration: const Duration(seconds: 2),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
