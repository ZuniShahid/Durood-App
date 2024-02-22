import 'dart:convert';

import 'package:durood_app/constants/no_data_widget.dart';
import 'package:durood_app/controllers/auth_controller.dart';
import 'package:durood_app/utilities/widgets/custom_dialog.dart';
import 'package:durood_app/utilities/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/page_navigation.dart';
import '../../controllers/data_controller.dart';
import '../../controllers/room_controller.dart';
import 'custom_room_detail.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  @override
  void initState() {
    _dataController.fetchGroupsData();
    super.initState();
  }

  final DataController _dataController = Get.find<DataController>();
  final AuthController _authController = Get.find<AuthController>();

  final RoomController _roomController = Get.put(RoomController());

  final TextEditingController _groupIdController = TextEditingController();

  void _handleAddToGroup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Group ID'),
        content: TextField(
          controller: _groupIdController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Group ID',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String groupId = _groupIdController.text.trim();
              if (groupId.isNotEmpty) {
                // Call API with the entered group ID
                _addToGroup(groupId);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _addToGroup(String groupId) async {
    CustomDialogBox.showLoading('Adding in a group....');
    var headers = {'Authorization': 'Bearer ${_authController.accessToken.value}'};
    var request = http.MultipartRequest('POST', Uri.parse('https://eramsaeed.com/Durood-App/api/rooms/add/user'));
    request.fields.addAll({
      'user_id': _authController.userData.value.id.toString(),
      'group_id': groupId,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    CustomDialogBox.hideLoading();
    var res = await response.stream.bytesToString();
    var result = json.decode(res);
    if (response.statusCode == 200) {
      if (!result['Error']) {
        _dataController.fetchGroupsData();
        Navigator.pop(context);
        CustomToast.successToast(message: result['Message']);
        await _roomController.getRoomDetails(
          groupId.toString(),
        );
        Go.to(() => CustomRoomDetail(roomId: groupId));
      } else {
        CustomToast.errorToast(message: result['Message']);
        Navigator.pop(context);
      }
      // Handle success
    } else {
      print(response.reasonPhrase);
      // Handle error
    }
  }

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddToGroup,
        label: const Text('Join a Group'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Rooms',
              style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
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
                } else if (_dataController.groups.isEmpty) {
                  return const Center(
                    child: NoDataWidget(
                      text: 'No rooms available.',
                    ),
                  );
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
                                roomId: _dataController.groups[index].id.toString(),
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
                              title: Text(_dataController.groups[index].groupName ?? ''),
                              subtitle: Text('Room ID: ${_dataController.groups[index].id ?? ''}'),
                              trailing: Text('Completed Target: ${_dataController.groups[index].targetCompleted ?? 0}'),
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
