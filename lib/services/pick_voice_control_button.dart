import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../constants/app_colors.dart';
import 'audio_common.dart';

class TwoOptCtrls extends StatelessWidget {
  final AudioPlayer player;

  const TwoOptCtrls(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 32.0,
                height: 32.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                  size: 32.0,
                ),
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(
                  Icons.pause,
                  color: Colors.black,
                  size: 32.0,
                ),
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.replay,
                  color: Colors.black,
                  size: 32.0,
                ),
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.volume_up,
            color: Colors.black,
            size: 24.0,
          ),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
      ],
    );
  }
}

class ThreeOptCtrls extends StatelessWidget {
  final AudioPlayer player;

  const ThreeOptCtrls(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(
              Icons.replay_10,
              color: AppColors.accentColor,
              size: 32.0,
            ),
            onPressed: () {
              seek(const Duration(seconds: -10));
            },
          ),
          Container(
            decoration: const BoxDecoration(
                color: AppColors.accentColor, shape: BoxShape.circle),
            child: StreamBuilder<PlayerState>(
              stream: player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 56.0,
                    height: 56.0,
                    child: const CircularProgressIndicator(),
                  );
                } else if (playing != true) {
                  return IconButton(
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 56.0,
                    ),
                    onPressed: player.play,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    icon: const Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 56.0,
                    ),
                    onPressed: player.pause,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(
                      Icons.replay,
                      color: Colors.white,
                      size: 56.0,
                    ),
                    onPressed: () => player.seek(Duration.zero),
                  );
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.forward_10,
              color: AppColors.accentColor,
              size: 32.0,
            ),
            onPressed: () {
              seek(const Duration(seconds: 10));
            },
          ),
          // IconButton(
          //   icon: const Icon(
          //     Icons.volume_up,
          //     color: Colors.black,
          //     size: 24.0,
          //   ),
          //   onPressed: () {
          //     showSliderDialog(
          //       context: context,
          //       title: "Adjust volume",
          //       divisions: 10,
          //       min: 0.0,
          //       max: 1.0,
          //       value: player.volume,
          //       stream: player.volumeStream,
          //       onChanged: player.setVolume,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  void seek(Duration offset) {
    try {
      final newPosition = player.position + offset;
      player.seek(newPosition);
    } catch (e) {
      // Handle errors here (e.g., log, display an error message)
      print("Error while seeking: $e");
    }
  }
}
