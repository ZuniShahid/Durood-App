import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'audio_common.dart';

class AudioPlayerService {
  final AudioPlayer player = AudioPlayer();

  Future<void> init(String audioUrl) async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });

    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  void play() {
    player.play();
  }

  void pause() {
    player.pause();
  }

  void seek(Duration position) {
    player.seek(position);
  }

  void stop() {
    player.stop();
  }

  Stream<PlayerState> get playerStateStream => player.playerStateStream;
  Stream<Duration> get positionStream => player.positionStream;
  Stream<Duration> get bufferedPositionStream => player.bufferedPositionStream;
  Stream<Duration?> get durationStream => player.durationStream;
  Stream<double> get volumeStream => player.volumeStream;
  double get volume => player.volume;

  void setVolume(double volume) {
    player.setVolume(volume);
  }

  void dispose() {
    player.dispose();
  }

  Stream<PositionData> get positionDataStream => _positionDataStream;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );
}
