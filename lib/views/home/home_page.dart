import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/next_button.dart';
import '../../constants/page_navigation.dart';
import '../../controllers/data_controller.dart';
import '../../generated/assets.dart';
import '../../models/voice_model.dart';
import '../../services/audio_common.dart';
import '../../services/audio_player_service.dart';
import '../../services/pick_voice_control_button.dart';
import '../custom_room/my_rooms.dart';
import 'common/SalawatCardWidget.dart';
import 'common/voice_selection_widget.dart';
import 'country.dart';
import 'durood_player_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final DataController dataController;
  final AudioPlayerService audioPlayerService = AudioPlayerService();

  String selectedVoice = '';

  @override
  void initState() {
    super.initState();
    dataController = Get.put(DataController());
    dataController.fetchData().then((_) {
      // Initiate data fetching and select the first voice when data is loaded
      if (dataController.topVoices.isNotEmpty) {
        handleVoiceSelected(dataController.topVoices.first.name ?? '');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayerService.dispose();
    super.dispose();
  }

  void playVoice(String voiceUrl) {
    print(voiceUrl);
    audioPlayerService.init(voiceUrl);
    audioPlayerService.play();
  }

  void handleVoiceSelected(String voice) {
    print(voice);
    selectedVoice = voice;
    playVoice(getVoiceUrlFromName(voice));
    setState(() {});
  }

  String getVoiceUrlFromName(String voiceName) {
    final VoiceModel selectedVoice = dataController.topVoices.firstWhere(
      (voice) => voice.name == voiceName,
      orElse: () => VoiceModel(),
    );
    return selectedVoice.file ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Durood',
          style: TextStyle(
            fontSize: 31,
            color: AppColors.textOverWhite,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              width: 100,
              height: 34,
              child: CommonElevatedButton(
                onPressed: () {
                  // Go.to(() => const CreateCustomRoom());
                  Go.to(() => RoomListScreen());
                },
                label: 'Custom Room',
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        // Use Obx to reactively rebuild the widget when data changes
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              DuroodPlayerCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder<PositionData>(
                      stream: audioPlayerService.positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SeekBarHomePage(
                            duration: positionData?.duration ?? Duration.zero,
                            position: positionData?.position ?? Duration.zero,
                            bufferedPosition:
                                positionData?.bufferedPosition ?? Duration.zero,
                            onChangeEnd: audioPlayerService.player.seek,
                          ),
                        );
                      },
                    ),
                    ThreeOptCtrls(audioPlayerService.player),
                  ],
                ),
              ),
              const Text(
                'Pick a voice',
                style: TextStyle(color: Color(0xFF6C717B)),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'People doing Salawat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Go.to(() => CountriesShownScreen());
                    },
                    child: const Text(
                      'See Where They’re From',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // VoiceSelectionWidget with data from DataController
              VoiceSelectionWidget(
                voices: dataController.topVoices
                    .map((voice) => voice.name ?? '')
                    .toList(),
                selectedVoice: selectedVoice,
                onVoiceSelected: handleVoiceSelected,
              ),
              const SizedBox(height: 30),

              // Display loading indicator if data is still loading
              if (dataController.isLoading.value)
                const CircularProgressIndicator()
              else
                Column(
                  // Display data if not loading
                  children: [
                    // SalwatCardWidget with data from DataController
                    SalwatCardWidget(
                      backgroundImageAsset: Assets.imagesIntro1,
                      primaryLabelText: 'Right Now',
                      secondaryLabelText: 'Invite Others',
                      countLabelText:
                          dataController.currentSalawatCount.value.toString(),
                      iconAsset: Assets.imagesSatelliteAntenna,
                      descriptionText: 'People are doing Salawat with you',
                    ),
                    const SizedBox(height: 15),
                    // SalwatCardWidget with data from DataController
                    SalwatCardWidget(
                      backgroundImageAsset: Assets.imagesSalwatWorld,
                      primaryLabelText: 'Global Count',
                      secondaryLabelText: '',
                      secondaryButtonColor: Colors.transparent,
                      countLabelText:
                          dataController.globalSalawatCount.value.toString(),
                      iconAsset: Assets.imagesIconGlobe,
                      descriptionText: 'Salawats have been shared worldwide',
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }
}
