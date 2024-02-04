import 'dart:convert';

import 'package:get/get.dart';

import '../api_services/data_api.dart';
import '../constants/page_navigation.dart';
import '../models/home_room_model.dart';
import '../models/voice_model.dart';
import '../views/home/pick_voices.dart';

class DataController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<VoiceModel> topVoices = <VoiceModel>[].obs;
  RxInt currentSalawatCount = 0.obs;
  RxInt globalSalawatCount = 0.obs;
  RxList<HomeRoomModel> groups = <HomeRoomModel>[].obs;

  RxString selectedVoice = ''.obs;

  void handleVoiceSelected(String voice) {
    if (voice == 'Custom') {
      // Handle the case when the user selects 'Custom'
      Go.to(() => const PickVoicesScreen());
    } else {
      selectedVoice.value = voice;
    }
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;

      // Fetching data from the 'home' endpoint
      var homeData = await DataApiService.instance.get('home');
      handleSuccess(homeData);
    } catch (error) {
      handleError(error);
    } finally {
      isLoading.value = false;
    }
  }

  void handleSuccess(String? homeData) {
    if (homeData != null) {
      var homeResult = json.decode(homeData);

      // Extracting data from the JSON response
      if (!homeResult['Error']) {
        topVoices.assignAll(List.from(homeResult['Top_voices'])
            .map((item) => VoiceModel.fromJson(item)));
        currentSalawatCount.value = homeResult['Current_salawat_count'];
        globalSalawatCount.value = homeResult['Global_salawat_count'];
        groups.assignAll(List.from(homeResult['groups'])
            .map((item) => HomeRoomModel.fromJson(item)));
      } else {
        // Handle error if needed
        // CustomDialogBox.showErrorDialog(description: homeResult["Message"]);
      }
    }
  }

  void handleError(dynamic error) {
    // Handle generic error
    // Log the error or show a user-friendly message
    print('Error: $error');
  }
}
