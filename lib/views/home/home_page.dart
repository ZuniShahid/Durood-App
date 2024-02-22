import 'package:durood_app/utilities/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/next_button.dart';
import '../../constants/page_navigation.dart';
import '../../controllers/data_controller.dart';
import '../../generated/assets.dart';
import '../../models/home_room_model.dart';
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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final DataController dataController = Get.put(DataController());
  final AudioPlayerService audioPlayerService = AudioPlayerService();
  String selectedVoice = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    dataController.fetchData().then((_) {
      if (dataController.isLoading.value == false && dataController.topVoices.isNotEmpty) {
        handleVoiceSelected(dataController.topVoices.first.voice!.name!);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    audioPlayerService.stop();
    audioPlayerService.dispose();
  }

  Future<void> playVoice(String voiceUrl) async {
    try {
      print(voiceUrl);
      await audioPlayerService.init(voiceUrl);
      audioPlayerService.play();
    } catch (e) {
      print('Error during audio playback: $e');
    }
  }

  void handleVoiceSelected(String voice) {
    try {
      print(voice);
      selectedVoice = voice;
      playVoice(getVoiceUrlFromName(voice));
      setState(() {});
    } catch (e) {
      print('Error during voice selection or playback: $e');
    }
  }

  String getVoiceUrlFromName(String voiceName) {
    final HomeVoiceModel selectedVoice = dataController.topVoices.firstWhere(
      (voice) => voice.voice!.name == voiceName,
      orElse: () => HomeVoiceModel(),
    );
    return selectedVoice.voice?.file != null ? selectedVoice.voice!.file! : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Durood',
          style: TextStyle(fontSize: 31, color: AppColors.textOverWhite),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              width: 100,
              height: 34,
              child: CommonElevatedButton(
                onPressed: () {
                  audioPlayerService.pause();
                  Go.to(() => const RoomListScreen());
                },
                label: 'Custom Room',
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
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
                            bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                            onChangeEnd: audioPlayerService.player.seek,
                          ),
                        );
                      },
                    ),
                    ThreeOptCtrls(
                      audioPlayerService.player,
                      onReload: () async {
                        if (selectedVoice != '') {
                          await audioPlayerService.init(getVoiceUrlFromName(selectedVoice));
                          audioPlayerService.play();
                        } else {
                          CustomToast.errorToast(message: 'Select Voice to play Salawat');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Text('Pick a voice', style: TextStyle(color: Color(0xFF6C717B))),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select a voice', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  GestureDetector(
                    onTap: () {
                      audioPlayerService.pause();
                      Go.to(() => CountriesShownScreen());
                    },
                    child: const Text('See Where They’re From',
                        style: TextStyle(decoration: TextDecoration.underline, fontSize: 13)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              VoiceSelectionWidget(
                voices: dataController.topVoices.map((voice) => voice.voice!.name ?? '').toList(),
                selectedVoice: selectedVoice,
                onVoiceSelected: handleVoiceSelected,
              ),
              const SizedBox(height: 30),
              if (dataController.isLoading.value && dataController.globalSalawatCount.value == 0)
                const CircularProgressIndicator()
              else
                Column(
                  children: [
                    SalwatCardWidget(
                      backgroundImageAsset: Assets.imagesIntro1,
                      primaryLabelText: 'Right Now',
                      secondaryLabelText: 'Invite Others',
                      countLabelText: dataController.currentSalawatCount.value.toString(),
                      iconAsset: Assets.imagesSatelliteAntenna,
                      descriptionText: 'People are doing Salawat with you',
                    ),
                    const SizedBox(height: 15),
                    SalwatCardWidget(
                      backgroundImageAsset: Assets.imagesSalwatWorld,
                      primaryLabelText: 'Global Count',
                      secondaryLabelText: '',
                      secondaryButtonColor: Colors.transparent,
                      countLabelText: dataController.globalSalawatCount.value.toString(),
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
