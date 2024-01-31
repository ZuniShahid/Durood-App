import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:durood_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:sizer/sizer.dart';

import '../../constants/circle_image.dart';

class CustomRoomDetail extends StatefulWidget {
  const CustomRoomDetail({super.key});

  @override
  State<CustomRoomDetail> createState() => _CustomRoomDetailState();
}

class _CustomRoomDetailState extends State<CustomRoomDetail> {
  final TextEditingController _textEditingController = TextEditingController();

  late ValueNotifier<double> valueNotifier;

  @override
  void initState() {
    valueNotifier = ValueNotifier(30.0);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const FittedBox(
          fit: BoxFit.contain,
          child: Text(
            'Room by Rashid Khan',
            style: TextStyle(fontSize: 24),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.cancel_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Group Description',
              style: TextStyle(color: AppColors.textGrey, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: AutoSizeTextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                    hintText: 'Group Name Here',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: AppColors.textOverWhite)),
                fullwidth: false,
                minFontSize: 24,
                minWidth: 100.w,
                maxLines: 2,
                style: const TextStyle(fontSize: 50),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 60),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 25.w,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 22.w,
                    decoration: const BoxDecoration(
                      color: AppColors.accentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SimpleCircularProgressBar(
                    backColor: AppColors.textGrey,
                    fullProgressColor: Color(0xFF50E3C2),
                    progressColors: const [
                      Color(0xFF50E3C2),
                      Color(0xFF09201B)
                    ],
                    backStrokeWidth: 24,
                    progressStrokeWidth: 22,
                    size: 30.w,
                    valueNotifier: valueNotifier,
                    mergeMode: true,
                    onGetText: (double value) {
                      return Text(
                        '${value.toInt()}%',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
