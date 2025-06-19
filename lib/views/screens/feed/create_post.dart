import 'dart:io';
import 'package:developper_look/utilities/app_icons.dart';
import 'package:developper_look/views/base/components/custom_svg_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/app_strings.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Pick image function
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Share',
                  style: textTheme.displayLarge?.copyWith(color: Colors.black, fontSize: 22),
                ),
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.clear)),
              ],
            ),

            /// Upload Image Section ============ >
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: _pickImage,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: [8, 2],
                      color: AppColors.black.withValues(alpha: 0.4),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(56, 78, 183, 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _image == null
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomSvgImage(
                              assetName: AppIcons.uploadImageIcon,
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Browse your image from the device gallery',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 150,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: AppColors.black),
                                  ),
                                ),
                                onPressed: _pickImage,
                                child: Text(
                                  AppString.browseFiles,
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



