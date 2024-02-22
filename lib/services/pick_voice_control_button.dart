import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../constants/app_colors.dart';
import 'audio_common.dart';

class TwoOptCtrls extends StatefulWidget {
  final AudioPlayer player;
  final ReloadCallback onReload;

  const TwoOptCtrls(this.player, {super.key, required this.onReload});

  @override
  State<TwoOptCtrls> createState() => _TwoOptCtrlsState();
}

class _TwoOptCtrlsState extends State<TwoOptCtrls> {
  @override
  void dispose() {
    widget.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<PlayerState>(
          stream: widget.player.playerStateStream,
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
                onPressed: widget.player.play,
              );
            } else if (processingState != ProcessingState.completed &&
                processingState != ProcessingState.idle) {
              return IconButton(
                icon: const Icon(
                  Icons.pause,
                  color: Colors.black,
                  size: 32.0,
                ),
                onPressed: widget.player.pause,
              );
            } else if (processingState == ProcessingState.idle) {
              return IconButton(
                icon: const Icon(
                  Icons.error,
                  color: Colors.black,
                  size: 32.0,
                ),
                onPressed: widget.onReload,
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.replay,
                  color: Colors.black,
                  size: 32.0,
                ),
                onPressed: () => widget.player.seek(Duration.zero),
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
              value: widget.player.volume,
              stream: widget.player.volumeStream,
              onChanged: widget.player.setVolume,
            );
          },
        ),
      ],
    );
  }
}

typedef ReloadCallback = void Function();

class ThreeOptCtrls extends StatefulWidget {
  final AudioPlayer player;
  final ReloadCallback onReload;

  const ThreeOptCtrls(this.player, {required this.onReload, Key? key})
      : super(key: key);

  @override
  State<ThreeOptCtrls> createState() => _ThreeOptCtrlsState();
}

class _ThreeOptCtrlsState extends State<ThreeOptCtrls> {
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
              stream: widget.player.playerStateStream,
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
                    onPressed: widget.player.play,
                  );
                } else if (processingState != ProcessingState.completed &&
                    processingState != ProcessingState.idle) {
                  return IconButton(
                    icon: const Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 56.0,
                    ),
                    onPressed: widget.player.pause,
                  );
                } else if (processingState == ProcessingState.idle) {
                  return IconButton(
                    icon: const Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 56.0,
                    ),
                    onPressed: widget.onReload,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(
                      Icons.replay,
                      color: Colors.white,
                      size: 56.0,
                    ),
                    onPressed: () => widget.player.seek(Duration.zero),
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
        ],
      ),
    );
  }

  void seek(Duration offset) {
    try {
      final newPosition = widget.player.position + offset;
      widget.player.seek(newPosition);
    } catch (e) {
      print("Error while seeking: $e");
    }
  }

  @override
  void dispose() {
    widget.player
        .dispose(); // Dispose of the player when the widget is disposed
    super.dispose();
  }
}
