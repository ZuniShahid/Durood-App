import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/account_exists_check.dart';
import '../../constants/app_colors.dart';
import '../../constants/common_text_field.dart';
import '../../constants/custom_validators.dart';
import '../../constants/next_button.dart';
import '../../controllers/auth_controller.dart';
import '../../generated/assets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController _authController = Get.find<AuthController>();

  bool checkboxValue = false;
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  bool loader = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final bool _isValidate = false;
  bool rememberMe = false;

  Widget doubleSpace() {
    return const SizedBox(
      height: 30,
    );
  }

  Widget singleSpace() {
    return const SizedBox(
      height: 10,
    );
  }

  Column _innerBody() {
    return Column(
      children: <Widget>[
        CommonTextField(
          label: 'Name',
          controller: _nameController,
          hintText: 'Name',
          onChanged: (value) {
            setState(() {});
          },
          validator: (value) => CustomValidator.isEmpty(value),
        ),
        const SizedBox(height: 10),
        CommonTextField(
          label: 'Email',
          controller: _emailController,
          textInputType: TextInputType.emailAddress,
          hintText: 'Email',
          onChanged: (value) {
            setState(() {});
          },
          validator: (value) => CustomValidator.email(value),
        ),
        singleSpace(),
        CommonTextField(
          label: 'Password',
          controller: passwordController,
          hintText: 'Password',
          onChanged: (value) {
            setState(() {});
          },
          validator: (value) {
            if (value!.isEmpty || value.length < 8) {
              return "Please Enter Valid Password";
            } else {
              return null;
            }
          },
          isPassword: true,
        ),
        singleSpace(),
        CommonTextField(
          label: 'Gender',
          controller: _genderController,
          hintText: 'Gender',
          onChanged: (value) {
            setState(() {});
          },
          validator: (value) => CustomValidator.isEmpty(value),
        ),
        singleSpace(),
        CommonTextField(
          label: 'City',
          controller: _cityController,
          hintText: 'City',
          onChanged: (value) {
            setState(() {});
          },
          validator: (value) => CustomValidator.isEmpty(value),
        ),
        singleSpace(),
        CommonTextField(
          textInputType: TextInputType.phone,
          label: 'Phone Number',
          controller: _phoneController,
          hintText: 'Phone Number',
          onChanged: (value) {
            setState(() {});
          },
          validator: (value) => CustomValidator.isEmpty(value),
        ),
        singleSpace(),
        doubleSpace(),
      ],
    );
  }

  void _loginButtonPressed() {
    var body = {
      'name': _nameController.text,
      'email': _emailController.text,
      'password': passwordController.text,
      'city': _cityController.text,
      'phone': _phoneController.text,
      'gender': _genderController.text,
    };

    var otpBody = {'email': _emailController.text, 'otp': '1'};

    _authController.verifyOtp(otpBody, body);
    // _authController.signUp(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.imagesLoginBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        Assets.imagesLogo,
                        width: 100,
                        height: 64,
                        color: AppColors.accentColor,
                      ),
                    ),
                    singleSpace(),
                    singleSpace(),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Create a new account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    doubleSpace(),
                    _innerBody(),
                    CommonElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _loginButtonPressed();
                        }
                      },
                      label: 'Sign Up',
                    ),
                    singleSpace(),
                    singleSpace(),
                    const AlreadyHaveAnAccountCheck(
                      login: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
