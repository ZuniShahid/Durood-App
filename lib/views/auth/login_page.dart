import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/account_exists_check.dart';
import '../../constants/app_colors.dart';
import '../../constants/common_text_field.dart';
import '../../constants/custom_validators.dart';
import '../../constants/next_button.dart';
import '../../controllers/auth_controller.dart';
import '../../generated/assets.dart';
import 'forgot_password.dart';
import 'post_login/enable_notification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.find<AuthController>();

  bool checkboxValue = false;
  final TextEditingController idController = TextEditingController();
  bool isLoading = false;
  bool loader = false;
  final TextEditingController passwordController = TextEditingController();

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
          label: 'Email',
          controller: idController,
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
        doubleSpace(),
      ],
    );
  }

  void _loginButtonPressed() {
    var body = {
      'email': idController.text,
      'password': passwordController.text,
    };

    _authController.userLogin(body);
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
                height: 150,
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
                        'Login',
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
                        Get.to(() => EnableNotificationScreen());
                        if (_formKey.currentState!.validate()) {
                          _loginButtonPressed();
                        }
                      },
                      label: 'Log In',
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => ForgotPassword());
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFFEFAFA9),
                        ),
                      ),
                    ),
                    singleSpace(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'or continue with',
                        style: TextStyle(
                          fontSize: 17,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                    singleSpace(),
                    TextButton(
                      onPressed: () {
                        // GoogleAuthenticateProvider().signIn(true);
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.imagesGoogleIcon,
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(width: 15),
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  color: AppColors.textOverWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    singleSpace(),
                    const AlreadyHaveAnAccountCheck(
                      login: true,
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
