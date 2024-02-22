import 'dart:convert';

import 'package:durood_app/constants/app_colors.dart';
import 'package:durood_app/utilities/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../api_services/data_api.dart';
import '../../constants/circle_image.dart';
import '../../constants/no_data_widget.dart';
import '../../models/voice_model.dart';
import '../../services/audio_common.dart';
import '../../services/audio_player_service.dart';
import '../../services/pick_voice_control_button.dart';

class PickVoicesScreen extends StatefulWidget {
  const PickVoicesScreen({Key? key}) : super(key: key);

  @override
  _PickVoicesScreenState createState() => _PickVoicesScreenState();
}

class _PickVoicesScreenState extends State<PickVoicesScreen> {
  final AudioPlayerService audioPlayerService = AudioPlayerService();
  late List<VoiceModel> voices = [];
  VoiceModel? selectedVoice;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    audioPlayerService.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      var voicesData = await DataApiService.instance.get('voices/all');
      if (mounted) {
        handleSuccess(voicesData);
      }
    } catch (error) {
      print('Error fetching voices: $error');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void handleSuccess(String? voicesData) {
    if (voicesData != null) {
      var voicesResult = json.decode(voicesData);

      if (!voicesResult['Error']) {
        var voicesList = List.from(voicesResult['Voices'])
            .map((item) => VoiceModel.fromJson(item))
            .toList();

        setState(() {
          voices = voicesList;
          isLoading = false;
        });
      } else {
        print('Error: ${voicesResult["Message"]}');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            const Text(
              'Pick a voice',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'Choose among several different voices for Salawat',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : voices.isEmpty
                      ? const Center(
                          child: NoDataWidget(
                            text: 'No voices available.',
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemCount: voices.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              if (voices[index].voice != null &&
                                  voices[index].voice!.file != null) {
                                playVoice(voices[index].voice!.file! ?? '');
                              } else {
                                CustomToast.errorToast(
                                    message:
                                        'Salawaats not found for the selected voice.');
                              }
                              setState(() {
                                selectedVoice = voices[index];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF5F1F1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: selectedVoice == voices[index]
                                          ? AppColors.accentColor
                                          : Colors.transparent)),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  CircleImage(
                                      imageUrl:
                                          voices[index].voice!.photo! ?? ''),
                                  const SizedBox(height: 10),
                                  Text(
                                    voices[index].voice!.name!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF93989D)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 8),
                    child: Row(
                      children: [
                        CircleImage(
                          imageUrl: selectedVoice?.voice?.photo ?? '',
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedVoice?.voice?.name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TwoOptCtrls(
                          audioPlayerService.player,
                          onReload: () {
                            if (selectedVoice != null &&
                                selectedVoice!.voice != null &&
                                selectedVoice!.voice!.file != null) {
                              playVoice(selectedVoice!.voice!.file! ?? '');
                            } else {
                              CustomToast.errorToast(
                                  message:
                                      'Salawaats not found for this voice. Please choose another.');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<PositionData>(
                    stream: audioPlayerService.positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SeekBar(
                          duration: positionData?.duration ?? Duration.zero,
                          position: positionData?.position ?? Duration.zero,
                          bufferedPosition:
                              positionData?.bufferedPosition ?? Duration.zero,
                          onChangeEnd: audioPlayerService.player.seek,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void playVoice(String voiceUrl) {
    print("voiceUrl");
    print(voiceUrl);
    audioPlayerService.init(voiceUrl);
    audioPlayerService.play();
  }
}
