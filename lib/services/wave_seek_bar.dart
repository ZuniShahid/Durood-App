import 'dart:math';

import 'package:flutter/material.dart';

import '../generated/assets.dart';
import 'audio_common.dart';

class WaveformSeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const WaveformSeekBar({
    super.key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _WaveformSeekBarState createState() => _WaveformSeekBarState();
}

class _WaveformSeekBarState extends State<WaveformSeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      thumbShape: HiddenThumbComponentShape(),
      activeTrackColor: Colors.blue, // Color for the foreground track
      inactiveTrackColor: Colors.grey, // Color for the background track
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.imagesAudiowave),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.grey,
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
              SliderTheme(
                data: _sliderThemeData.copyWith(
                  activeTrackColor: Colors.grey,
                ),
                child: Slider(
                  min: 0.0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: widget.position.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    if (widget.onChanged != null) {
                      widget.onChanged!(Duration(milliseconds: value.round()));
                    }
                  },
                  onChangeEnd: (value) {
                    if (widget.onChangeEnd != null) {
                      widget.onChangeEnd!(Duration(milliseconds: value.round()));
                    }
                  },
                ),
              ),
              SliderTheme(
                data: _sliderThemeData,
                child: Slider(
                  min: 0.0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: min(
                    _dragValue ?? widget.position.inMilliseconds.toDouble(),
                    widget.duration.inMilliseconds.toDouble(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _dragValue = value;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(Duration(milliseconds: value.round()));
                    }
                  },
                  onChangeEnd: (value) {
                    if (widget.onChangeEnd != null) {
                      widget.onChangeEnd!(Duration(milliseconds: value.round()));
                    }
                    _dragValue = null;
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch("$_remaining")?.group(1) ?? '$_remaining',
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;

  Duration get _total => widget.duration;
}

// Custom Thumb Shape to hide the seek bar thumb
