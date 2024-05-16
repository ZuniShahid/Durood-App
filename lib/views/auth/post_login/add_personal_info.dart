import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/circle_image.dart';
import '../../../constants/common_text_field.dart';
import '../../../constants/custom_validators.dart';
import '../../../constants/next_button.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/user_model.dart';

class AddPersonalInfoScreen extends StatefulWidget {
  const AddPersonalInfoScreen({super.key});

  @override
  State<AddPersonalInfoScreen> createState() => _AddPersonalInfoScreenState();
}

class _AddPersonalInfoScreenState extends State<AddPersonalInfoScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final UserModel userModel = Get.find<AuthController>().userData.value;

  final TextEditingController _nameController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;

  _pickImageFromGallery() async {
    pickedFile = await _picker.pickImage(imageQuality: 50, source: ImageSource.gallery);
    print(pickedFile!.path);
    setState(() {});
  }

  @override
  void initState() {
    _nameController.text = userModel.name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: () {
                _authController.signOut();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // Red color
              ),
              child: const Text(
                'Log out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                              fit: BoxFit.cover,
                            ),
                          )
                        : CircleImage(imageUrl: userModel.image!)),
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
                    label: 'Gender',
                    controller: TextEditingController(text: userModel.gender),
                    hintText: 'Gender',
                    readOnly: true,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 15),
                  CommonTextField(
                    label: 'Country',
                    controller: TextEditingController(text: userModel.city),
                    hintText: 'Country',
                    readOnly: true,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 15),
                  CommonTextField(
                    label: 'Phone',
                    controller: TextEditingController(text: userModel.phone),
                    hintText: 'Phone',
                    readOnly: true,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
              child: CommonElevatedButton(
                onPressed: () async {
                  if (pickedFile != null) {
                    await _authController.editProfile(userModel.id!.toString(), _nameController.text, pickedFile!.path);
                  } else {
                    await _authController.editProfile(userModel.id!.toString(), _nameController.text, null);
                  }
                },
                label: 'Update',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
              child: CommonElevatedButton(
                backgroundColor: Colors.red,
                onPressed: () async {
                  bool shouldDelete = await showConfirmationDialog(context);
                  if (shouldDelete) {
                    await _authController.deleteAccount();
                  }
                },
                label: 'Delete Account',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Deletion'),
              content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                ElevatedButton(
                  child: const Text('Delete'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false; // Return false if the dialog is dismissed
  }
}
