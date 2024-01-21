import 'dart:io';

import 'package:durood_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/common_text_field.dart';
import '../../../constants/custom_validators.dart';
import '../../../constants/next_button.dart';
import '../../../generated/assets.dart';
import 'post_login_onboarding.dart';

class AddPersonalInfoScreen extends StatefulWidget {
  const AddPersonalInfoScreen({super.key});

  @override
  State<AddPersonalInfoScreen> createState() => _AddPersonalInfoScreenState();
}

class _AddPersonalInfoScreenState extends State<AddPersonalInfoScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;

  _pickImageFromGallery() async {
    pickedFile =
        await _picker.pickImage(imageQuality: 50, source: ImageSource.gallery);
    print(pickedFile!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
        child: CommonElevatedButton(
          onPressed: () {
            Get.to(() => const PostOnBoardingScreen());
          },
          label: 'Continue',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.0, top: 10.0.h),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'SKIP',
                    style: TextStyle(color: Color(0xFFD7D5D5)),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Personal Info',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 31,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  _pickImageFromGallery();
                },
                child: Container(
                  height: 159,
                  width: 159,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: pickedFile != null
                      ? ClipOval(
                          child: Image.file(
                            File(pickedFile!.path),
                            fit: BoxFit
                                .fill, // Use BoxFit.fill to fill the entire container
                          ),
                        )
                      : Image.asset(Assets.imagesImagePick),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextField(
                    label: 'Name',
                    controller: _nameController,
                    hintText: 'Name',
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) => CustomValidator.isEmpty(value),
                  ),
                  const SizedBox(height: 15),
                  CommonTextField(
                    label: 'Name',
                    controller: _nameController,
                    hintText: 'Name',
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) => CustomValidator.isEmpty(value),
                  ),
                  const SizedBox(height: 15),
                  CommonTextField(
                    label: 'Name',
                    controller: _nameController,
                    hintText: 'Name',
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) => CustomValidator.isEmpty(value),
                  ),
                  const SizedBox(height: 15),
                  CommonTextField(
                    label: 'Name',
                    controller: _nameController,
                    hintText: 'Name',
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) => CustomValidator.isEmpty(value),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
