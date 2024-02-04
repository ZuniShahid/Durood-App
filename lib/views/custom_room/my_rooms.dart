import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/page_navigation.dart';
import '../../controllers/data_controller.dart';
import '../../controllers/room_controller.dart';
import 'custom_room_detail.dart';

class RoomListScreen extends StatefulWidget {
  RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  final DataController _dataController = Get.find<DataController>();

  final RoomController _roomController = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Rooms',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'Rooms Created by me',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Obx(
              () {
                if (_dataController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _dataController.groups.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await _roomController.getRoomDetails(
                              _dataController.groups[index].id.toString(),
                            );
                            Go.to(
                              () => CustomRoomDetail(
                                roomId:
                                    _dataController.groups[index].id.toString(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F1F1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                  _dataController.groups[index].groupName ??
                                      ''),
                              subtitle: Text(
                                  'Participants: ${_dataController.groups[index].totalParticipants ?? ''}'),
                              trailing: Text(
                                  'Completed Target: ${_dataController.groups[index].targetCompleted ?? 0}'),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
