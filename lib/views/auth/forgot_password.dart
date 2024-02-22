import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/common_text_field.dart';
import '../../constants/custom_validators.dart';
import '../../constants/next_button.dart';
import '../../controllers/auth_controller.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final TextEditingController _emailController = TextEditingController();

  final AuthController _authController = AuthController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 186),
                const Text(
                  'Forgot password',
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
                    "Enter your email address, we will send you code to reset your password.",
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CommonTextField(
                  label: 'Email',
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                  hintText: 'Enter your email',
                  onChanged: (value) {},
                  validator: (value) => CustomValidator.email(value),
                  isRequired: false,
                ),
                const SizedBox(height: 40),
                CommonElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var body = {'email': _emailController.text};
                      _authController.forgotPassword(body);
                    }
                  },
                  label: 'Get password reset email',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
