import 'dart:convert';

import 'package:durood_app/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../api_services/data_api.dart';
import '../constants/page_navigation.dart';
import '../models/home_room_model.dart';
import '../views/home/pick_voices.dart';

class DataController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<HomeVoiceModel> topVoices = <HomeVoiceModel>[].obs;
  RxInt currentSalawatCount = 0.obs;
  RxInt globalSalawatCount = 0.obs;
  RxList<HomeRoomModel> groups = <HomeRoomModel>[].obs;

  RxString selectedVoice = ''.obs;

  void handleVoiceSelected(String voice) {
    if (voice == 'Custom') {
      Go.to(() => const PickVoicesScreen());
    } else {
      selectedVoice.value = voice;
    }
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;

      var homeData = await DataApiService.instance.get('home');
      handleSuccess(homeData);
    } catch (error) {
      handleError(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchGroupsData() async {
    try {
      var homeData = await DataApiService.instance.get('home');
      handleGroupsSuccess(homeData);
    } catch (error) {
      handleError(error);
    } finally {}
  }

  void handleSuccess(String? homeData) {
    if (homeData != null) {
      var homeResult = json.decode(homeData);
      print("homeResult");
      print(homeResult);

      if (!homeResult['Error']) {
        topVoices.assignAll(List.from(homeResult['Top_voices']).map((item) => HomeVoiceModel.fromJson(item)));
        currentSalawatCount.value = homeResult['Current_salawat_count'];
        globalSalawatCount.value = homeResult['Global_salawat_count'];
        groups.assignAll(List.from(homeResult['groups']).map((item) => HomeRoomModel.fromJson(item)));
      } else {}
    }
  }

  void handleGroupsSuccess(String? homeData) {
    if (homeData != null) {
      var homeResult = json.decode(homeData);

      if (!homeResult['Error']) {
        groups.assignAll(List.from(homeResult['groups']).map((item) => HomeRoomModel.fromJson(item)));
      } else {}
    }
  }

  void handleError(dynamic error) {
    print('Error: $error');
  }

  Future<void> increaseTargetCount() async {
    try {
      final Map<String, dynamic> requestBody = {'user_id': Get.find<AuthController>().userData.value.id.toString()};
      var response = await DataApiService.instance.post('salawat/post', requestBody);
      var res = json.decode(response);
      print("result");
      print(res);
      if (!res['Error']) {
        globalSalawatCount.value = int.parse(res["Global_Salawat_count"].toString());
      }
    } catch (error) {
      print('Error increasing target count: $error');
      rethrow;
    } finally {}
  }
}
