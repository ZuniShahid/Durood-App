import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:durood_app/utilities/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../constants/circle_image.dart';
import '../../constants/next_button.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/room_controller.dart';

class CreateCustomRoom extends StatefulWidget {
  const CreateCustomRoom({super.key});

  @override
  State<CreateCustomRoom> createState() => _CreateCustomRoomState();
}

class _CreateCustomRoomState extends State<CreateCustomRoom> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _counterController = TextEditingController(text: '1');
  final TextEditingController _totalParticipants = TextEditingController(text: '0');

  final RoomController _roomController = Get.put(RoomController());

  Future<void> createRoom() async {
    try {
      await _roomController.createRoom(
        groupName: _textEditingController.text,
        adminName: Get.find<AuthController>().userData.value.name!,
        totalParticipants: "1000",
        target: _counterController.text,
      );
    } catch (error) {
      print('Error creating room: $error');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
        child: CommonElevatedButton(
          onPressed: () async {
            if (int.parse(_counterController.text) < 1) {
              CustomToast.errorToast(message: 'Target Durood count should be 1 or greater');
              return;
            }
            await createRoom();
          },
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
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleImage(
                  imageUrl: Get.find<AuthController>().userData.value.image!, placeHolderColor: Color(0xFFB1B1EB)),
              title: Text(
                Get.find<AuthController>().userData.value.name!,
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
                  decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_counterController.text.isNotEmpty && int.tryParse(_counterController.text) != null) {
                        int currentValue = int.parse(_counterController.text);
                        if (currentValue > 0) {
                          setState(() {
                            _counterController.text = (currentValue - 1).toString();
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
                  decoration: const BoxDecoration(color: AppColors.accentColor, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _counterController.text = (int.tryParse(_counterController.text)! + 1).toString();
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
            const SizedBox(height: 20),
            // const Text(
            //   'Total Participants',
            //   style: TextStyle(color: AppColors.textGrey, fontSize: 16),
            // ),
            // const SizedBox(height: 10),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 8),
            //   child: TextField(
            //     controller: _totalParticipants,
            //     keyboardType: TextInputType.number,
            //     textAlign: TextAlign.center,
            //     onChanged: (value) {
            //       setState(() {});
            //     },
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 40),
            // const Text(
            //   '🔴 Total Participants represents the total number of Participants you aim to add in this group. ',
            //   style: TextStyle(color: AppColors.textGrey, fontSize: 14),
            // ),
          ],
        ),
      ),
    );
  }
}
