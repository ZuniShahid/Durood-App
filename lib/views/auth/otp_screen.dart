import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/next_button.dart';
import '../../constants/otp_fields.dart';
import '../../constants/page_navigation.dart';
import '../../controllers/auth_controller.dart';
import '../../utilities/widgets/custom_toast.dart';
import 'reset_password.dart';

class OTPScreen extends StatefulWidget {
  final String otpCode;
  final String email;

  final body;

  final bool signUp;

  const OTPScreen({
    super.key,
    required this.otpCode,
    required this.email,
    this.signUp = false,
    this.body,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _otpController = TextEditingController();
  late String currentOtpCode;

  @override
  void initState() {
    currentOtpCode = widget.otpCode;
    super.initState();
  }

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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 186),
                const Text(
                  'OTP Verification',
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
                    "Enter the verification OTP we just sent you on your email Address.",
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                OtpField(otpController: _otpController),
                const SizedBox(height: 40),
                CommonElevatedButton(
                    label: "Verify Code",
                    onPressed: () {
                      if (_otpController.text.isEmpty) {
                        CustomToast.errorToast(message: "Enter OTP");
                        _otpController.clear();
                      } else if (_otpController.text.length < 4 ||
                          _otpController.text != currentOtpCode) {
                        CustomToast.errorToast(
                            message: "Invalid OTP. Please enter a valid OTP.");
                        _otpController.clear();
                      } else if (_otpController.text == currentOtpCode) {
                        if (widget.signUp) {
                          _authController.signUp(widget.body);
                        } else {
                          Go.to(() => ResetPassword(
                                email: widget.email,
                                otp: _otpController.text,
                              ));
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
