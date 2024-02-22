import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'app_colors.dart';

class OtpField extends StatefulWidget {
  TextEditingController otpController;

  OtpField({
    required this.otpController,
    Key? key,
  }) : super(key: key);

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  @override
  void dispose() {
    widget.otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: widget.otpController,
      appContext: context,
      textStyle: TextStyle(color: AppColors.accentColor, fontSize: 30),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      length: 4,
      obscureText: false,
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: (v) {
        return null;
      },
      pinTheme: PinTheme(
        borderWidth: 1.0,
        borderRadius: BorderRadius.circular(15),
        selectedColor: AppColors.borderColor,
        selectedFillColor: Colors.transparent,
        activeColor: AppColors.borderColor,
        activeFillColor: Colors.transparent,
        shape: PinCodeFieldShape.box,
        errorBorderColor: Colors.red,
        errorBorderWidth: 1.0,
        activeBorderWidth: 1.0,
        selectedBorderWidth: 1.0,
        inactiveColor: AppColors.borderColor,
        inactiveFillColor: Colors.transparent,
        fieldHeight: 55,
        fieldWidth: 50,
      ),
      cursorColor: AppColors.accentColor,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      onCompleted: (v) {},
      onChanged: (value) {
        if (value.isNotEmpty) {}
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        return true;
      },
    );
  }
}
