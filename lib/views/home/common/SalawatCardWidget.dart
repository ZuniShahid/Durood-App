import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants/app_colors.dart';

class SalwatCardWidget extends StatelessWidget {
  final String backgroundImageAsset;
  final String primaryLabelText;
  final String secondaryLabelText;

  final Color? secondaryButtonColor;
  final String countLabelText;
  final String iconAsset;
  final String descriptionText;

  const SalwatCardWidget({
    super.key,
    required this.backgroundImageAsset,
    required this.primaryLabelText,
    required this.secondaryLabelText,
    required this.countLabelText,
    required this.iconAsset,
    required this.descriptionText,
    this.secondaryButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Background Image with Black Overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.srcATop,
              ),
              child: Image.asset(
                backgroundImageAsset,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        primaryLabelText,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Share.share('here will be the link of app');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: secondaryButtonColor ?? AppColors.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          secondaryLabelText,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          countLabelText,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 29,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(
                          iconAsset,
                          color: Colors.white,
                          height: 23,
                          width: 23,
                        )
                      ],
                    ),
                    Text(
                      descriptionText,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
