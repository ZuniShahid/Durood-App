import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/common_text_field.dart';
import '../../constants/custom_validators.dart';
import '../../constants/next_button.dart';
import '../../controllers/auth_controller.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPassword({super.key, required this.email, required this.otp});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 186),
                const Text(
                  'Reset password',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Set your new password to login into your account!",
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CommonTextField(
                  label: 'New Password',
                  controller: _passwordController,
                  isPassword: true,
                  hintText: 'Enter new password',
                  onChanged: (value) {},
                  validator: (value) => CustomValidator.password(value),
                  isRequired: false,
                ),
                const SizedBox(height: 20),
                CommonTextField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  hintText: 'Confirm you password',
                  onChanged: (value) {},
                  validator: (value) => CustomValidator.confirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  isRequired: false,
                ),
                const SizedBox(height: 40),
                CommonElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      var body = {
                        'email': widget.email,
                        'otp': widget.otp,
                        'new_password': _passwordController.text,
                      };
                      print(body);
                      _authController.resetPassword(body);
                    }
                  },
                  label: 'Confirm',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
