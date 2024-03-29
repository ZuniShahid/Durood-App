import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'input_decorations.dart';

class CommonTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isRequired;
  final TextInputType textInputType;
  final bool readOnly;

  const CommonTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.isPassword = false,
    this.isRequired = false,
    this.textInputType = TextInputType.text,
    this.readOnly = false,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _obscureText = true;

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textGrey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextFormField(
              onChanged: widget.onChanged,
              obscureText: _obscureText && widget.isPassword,
              controller: widget.controller,
              validator: widget.validator,
              cursorColor: AppColors.accentColor,
              keyboardType: widget.textInputType,
              readOnly: widget.readOnly,
              decoration: InputDecorations.inputDecorationAllBorder(
                hintText: widget.hintText,
              ).copyWith(
                labelText: widget.label,
                suffixIcon: widget.isPassword
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.textGrey,
                          size: 20,
                        ),
                      )
                    : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
