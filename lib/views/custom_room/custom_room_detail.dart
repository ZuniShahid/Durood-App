import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../constants/circle_image.dart';
import '../../constants/next_button.dart';
import '../../controllers/room_controller.dart';

class CustomRoomDetail extends StatefulWidget {
  final String roomId;

  const CustomRoomDetail({Key? key, required this.roomId}) : super(key: key);

  @override
  _CustomRoomDetailState createState() => _CustomRoomDetailState();
}

class _CustomRoomDetailState extends State<CustomRoomDetail> {
  final TextEditingController _textEditingController = TextEditingController();

  late ValueNotifier<double> valueNotifier;

  final RoomController _roomController = Get.find<RoomController>();

  @override
  void initState() {
    super.initState();
    _fetchRoomDetails();
  }

  void _fetchRoomDetails() async {
    try {
      // await _roomController.getRoomDetails(widget.roomId);
      _updateUI();
    } catch (error) {
      print('Error fetching room details: $error');
    }
  }

  void _updateUI() {
    final completedTarget =
        _roomController.roomModel.value.completedTarget ?? 0;
    final groupTarget = _roomController.roomModel.value.groupTarget ?? 0;

    valueNotifier = ValueNotifier(completedTarget / groupTarget * 100.0);

    _textEditingController.text =
        _roomController.roomModel.value.groupName ?? '';

    if (mounted) {
      setState(() {});
    }
    print('Value Notifier After Update: ${valueNotifier.value}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: CommonElevatedButton(
          onPressed: () {
            if (_roomController.roomModel.value.completedTarget! <
                _roomController.roomModel.value.groupTarget!) {
              _roomController.increaseTargetCount(widget.roomId);
              _roomController.incrementCompletedTarget();
              _updateUI(); // Update UI to reflect the new value
            } else {
              // Handle the case where the target is already reached
              // You can show a message or take appropriate action.
              print('Target already reached!');
            }
          },
          label: _roomController.roomModel.value.completedTarget! <
                  _roomController.roomModel.value.groupTarget!
              ? 'Add'
              : 'Target already reached!',
          backgroundColor: _roomController.roomModel.value.completedTarget! <
                  _roomController.roomModel.value.groupTarget!
              ? AppColors.accentColor
              : AppColors.secondary,
          textColor: Colors.white,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            'Room by ${_roomController.roomModel.value.adminName}',
            style: const TextStyle(fontSize: 24),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  hintStyle: TextStyle(color: AppColors.textOverWhite),
                ),
                fullwidth: false,
                minFontSize: 24,
                minWidth: 100.w,
                maxLines: 2,
                style: const TextStyle(fontSize: 50),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Salawats delivered...",
              style: TextStyle(
                fontSize: 22,
                color: const Color(0xFF000E08).withOpacity(0.40),
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
                    key: ValueKey<double>(valueNotifier.value),
                    backColor: AppColors.textGrey,
                    fullProgressColor: const Color(0xFF50E3C2),
                    progressColors: const [
                      Color(0xFF50E3C2),
                      Color(0xFF09201B),
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
            const SizedBox(height: 40),
            const SizedBox(height: 40),
            Text(
              "Members in the Room",
              style: TextStyle(
                fontSize: 22,
                color: const Color(0xFF000E08).withOpacity(0.40),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                if (_roomController
                    .roomModel.value.addedParticipants!.isNotEmpty)
                  for (int i = 0;
                      i <
                              _roomController
                                  .roomModel.value.addedParticipants!.length &&
                          i < 3;
                      i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleImage(
                          imageUrl: _roomController
                              .roomModel.value.addedParticipants![i].image),
                    ),
                if (_roomController.roomModel.value.addedParticipants!.isEmpty)
                  const Text(
                    'No User',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 40),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
