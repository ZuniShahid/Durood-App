import 'package:audio_waveforms/audio_waveforms.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../constants/next_button.dart';
import '../../generated/assets.dart';
import '../custom_room/custom_room.dart';
import '../custom_room/custom_room_detail.dart';
import 'common/SalawatCardWidget.dart';
import 'common/voice_selection_widget.dart';
import 'durood_player_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final RecorderController recorderController;

  List<String> voicesName = [
    'M. Amir',
    'Anwar',
    'Mujtaba',
    'Custom',
  ];

  String selectedVoice = 'M. Amir';

  void handleVoiceSelected(String voice) {
    if (voice == 'Custom') {
      Get.to(() => CustomRoomDetail());
    } else {
      setState(() {
        selectedVoice = voice;
      });
    }
  }

  @override
  void initState() {
    _initialiseController();
    super.initState();
  }

  void _initialiseController() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;
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
                  Get.to(() => const CreateCustomRoom());
                },
                label: 'Custom Room',
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DuroodPlayerCard(
              child: Column(
                children: [
                  AudioWaveforms(
                    size: Size(MediaQuery.of(context).size.width, 20.0),
                    waveStyle: const WaveStyle(
                      waveColor: AppColors.accentColor,
                      extendWaveform: true,
                      showMiddleLine: false,
                    ),
                    recorderController: recorderController,
                  ),
                ],
              ),
            ),
            const Text(
              'Pick a voice',
              style: TextStyle(color: Color(0xFF6C717B)),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'People doing Salawat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'See Where They’re From',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            VoiceSelectionWidget(
              voices: voicesName,
              selectedVoice: selectedVoice,
              onVoiceSelected: handleVoiceSelected,
            ),
            const SizedBox(height: 30),
            const SalwatCardWidget(
              backgroundImageAsset: Assets.imagesIntro1,
              primaryLabelText: 'Right Now',
              secondaryLabelText: 'Invite Others',
              countLabelText: '4,995',
              iconAsset: Assets.imagesSatelliteAntenna,
              descriptionText: 'People are doing Salawat with you',
            ),
            const SizedBox(height: 15),
            const SalwatCardWidget(
              backgroundImageAsset: Assets.imagesSalwatWorld,
              primaryLabelText: 'Global Count',
              secondaryLabelText: 'Your Salawats',
              secondaryButtonColor: AppColors.accentColor,
              countLabelText: '~500,934',
              iconAsset: Assets.imagesIconGlobe,
              descriptionText: 'Salawats have been shared worldwide',
            ),
          ],
        ),
      ),
    );
  }
}
