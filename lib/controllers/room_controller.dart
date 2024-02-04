import 'dart:convert';

import 'package:get/get.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../models/room_model.dart';
import '../utilities/widgets/custom_dialog.dart';
import 'base_controller.dart';

class RoomController extends GetxController {
  RxBool isLoading = false.obs;
  final BaseController _baseController = BaseController.instance;

  Rx<RoomModel> roomModel = RoomModel().obs;

  void incrementCompletedTarget() {
    roomModel.value = roomModel.value.incrementCompletedTarget();
  }

  Future getRoomDetails(String groupId) async {
    print(groupId);
    isLoading.value = true;
    _baseController.showLoading('Fetching Group Details');
    final Map<String, dynamic> requestBody = {'group_id': groupId};
    final response = await DataApiService.instance
        .post('rooms/details', requestBody)
        .catchError((error) {
      if (error is BadRequestException) {
        return error.message!;
      } else {
        _baseController.handleError(error);
      }
    });
    if (response == null) return;

    _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (!result['Error']) {
      roomModel.value = RoomModel.fromJson(result['data']);
    } else {
      CustomDialogBox.showErrorDialog(description: result["Message"]);
      return result["Message"];
    }
  }

  Future<void> createRoom({
    required String groupName,
    required String adminName,
    required String totalParticipants,
    required String target,
  }) async {
    _baseController.showLoading('Creating room...');
    final Map<String, dynamic> requestBody = {
      'group_name': groupName,
      'admin_name': adminName,
      'total_participants': totalParticipants,
      'target': target,
    };
    var response = await DataApiService.instance
        .post('rooms/create', requestBody)
        .catchError((error) {
      if (error is BadRequestException) {
        return error.message!;
      } else {
        _baseController.handleError(error);
      }
    });
    if (response == null) return;

    _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (!result['Error']) {
      CustomDialogBox.showSuccessDialog(description: result["Message"]);
    } else {
      CustomDialogBox.showErrorDialog(description: result["Message"]);
      return result["Message"];
    }
  }

  Future<void> addParticipantToRoom(String userId, String groupId) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> requestBody = {
        'user_id': userId,
        'group_id': groupId
      };
      await DataApiService.instance.post('rooms/add/user', requestBody);
    } catch (error) {
      print('Error adding participant to room: $error');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> increaseTargetCount(String groupId) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> requestBody = {'group_id': groupId};
      await DataApiService.instance.post('rooms/salawat/post', requestBody);
    } catch (error) {
      print('Error increasing target count: $error');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> closeRoom(String roomId) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> requestBody = {'room_id': roomId};
      await DataApiService.instance.post('rooms/close', requestBody);
    } catch (error) {
      print('Error closing room: $error');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
