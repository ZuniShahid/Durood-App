import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/account_exists_check.dart';
import '../../constants/app_colors.dart';
import '../../constants/common_text_field.dart';
import '../../constants/custom_validators.dart';
import '../../constants/next_button.dart';
import '../../constants/page_navigation.dart';
import '../../controllers/auth_controller.dart';
import '../../generated/assets.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    print('object');
  }

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
    return const SizedBox(height: 10);
  }

  Column _innerBody() {
    return Column(
      children: <Widget>[
        CommonTextField(
          label: 'Email',
          controller: idController,
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
        doubleSpace(),
      ],
    );
  }

  Future<void> _loginButtonPressed() async {
    var body = {
      'email': idController.text,
      'password': passwordController.text,
    };

    await _authController.userLogin(body);
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
                        if (_formKey.currentState!.validate()) {
                          _loginButtonPressed();
                        }
                      },
                      label: 'Log In',
                    ),
                    TextButton(
                      onPressed: () {
                        Go.to(() => ForgotPassword());
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
