import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';

class VoiceSelectionWidget extends StatelessWidget {
  final List<String> voices;
  final String selectedVoice;
  final void Function(String) onVoiceSelected;

  const VoiceSelectionWidget({
    super.key,
    required this.voices,
    required this.selectedVoice,
    required this.onVoiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          voices.length,
          (index) {
            final voice = voices[index];
            final isSelected = voice == selectedVoice;

            return GestureDetector(
              onTap: () {
                onVoiceSelected(voice);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: index == voices.length - 1
                      ? AppColors.accentColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: index == voices.length - 1
                        ? AppColors.accentColor
                        : Colors.grey,
                  ),
                ),
                child: Text(
                  voice,
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
