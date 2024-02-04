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
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

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
        Container(
          height: 100,
          child: Stack(
            children: [
              // Background Image with Gray Color Overlay
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
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

              // Background Track (Gray)
              SliderTheme(
                data: _sliderThemeData.copyWith(
                  activeTrackColor: Colors.grey,
                ),
                child: Slider(
                  min: 0.0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: widget.position.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    // Allow changing the position by dragging the background
                    if (widget.onChanged != null) {
                      widget.onChanged!(Duration(milliseconds: value.round()));
                    }
                  },
                  onChangeEnd: (value) {
                    // Handle change end for the background track
                    if (widget.onChangeEnd != null) {
                      widget
                          .onChangeEnd!(Duration(milliseconds: value.round()));
                    }
                  },
                ),
              ),

              // Foreground Track (Colored)
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
                      widget
                          .onChangeEnd!(Duration(milliseconds: value.round()));
                    }
                    _dragValue = null;
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        // The existing text widget for displaying remaining time
        Text(
          RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("$_remaining")
                  ?.group(1) ??
              '$_remaining',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;

  Duration get _total => widget.duration;
}

// Custom Thumb Shape to hide the seek bar thumb
