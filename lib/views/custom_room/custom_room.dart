import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:durood_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/circle_image.dart';
import '../../constants/next_button.dart';

class CreateCustomRoom extends StatefulWidget {
  const CreateCustomRoom({super.key});

  @override
  State<CreateCustomRoom> createState() => _CreateCustomRoomState();
}

class _CreateCustomRoomState extends State<CreateCustomRoom> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _counterController =
      TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
        child: CommonElevatedButton(
          onPressed: () {},
          label: 'Create',
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text('Create Private Room'),
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
                    hintText: 'Name Your Group Here',
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
            const SizedBox(height: 20),
            const Text(
              'Group Admin',
              style: TextStyle(color: AppColors.textGrey, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleImage(
                  imageUrl: 'imageUrl', placeHolderColor: Color(0xFFB1B1EB)),
              title: Text(
                'Rashid Khan',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              subtitle: Text(
                'Group Admin',
                style: TextStyle(color: AppColors.textGrey, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Target Salawat',
              style: TextStyle(color: AppColors.textGrey, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.secondary, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_counterController.text.isNotEmpty &&
                          int.tryParse(_counterController.text) != null) {
                        int currentValue = int.parse(_counterController.text);
                        if (currentValue > 0) {
                          setState(() {
                            _counterController.text =
                                (currentValue - 1).toString();
                          });
                        }
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: _counterController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.accentColor, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _counterController.text =
                            (int.tryParse(_counterController.text)! + 1)
                                .toString();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '🔴 Target Salawat represents the total number of Salawat you aim to deliver in this group. '
              'Use the +/- buttons to set your desired count.',
              style: TextStyle(color: AppColors.textGrey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
