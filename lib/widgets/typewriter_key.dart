import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypewriterKey extends StatefulWidget {
  TypewriterKey({
    @required this.assetName,
    Key key,
    this.height,
    this.width,
    this.onTap,
    this.padding,
    this.soundAsset,
  }) : super(key: key);

  final double height;
  final double width;
  final Function onTap;
  final String assetName;
  final EdgeInsets padding;
  final String soundAsset;

  @override
  _TypewriterKeyState createState() => _TypewriterKeyState();
}

class _TypewriterKeyState extends State<TypewriterKey> with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  AudioCache _audioPlayer;

  @override
  void initState() {
    _audioPlayer = Provider.of<AudioCache>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        widget?.onTap?.call();
        setState(() {
          _audioPlayer.play(widget.soundAsset ?? 'sounds/typing_sound_2wav.wav');

          if (!_isPressed) {
            _isPressed = true;
          }
        });
      },
      onTapUp: (_) {
        setState(() {
          if (_isPressed) {
            _isPressed = false;
          }
        });
      },
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(4.0),
        child: _buildKey(),
      ),
    );
  }

  Widget _buildKey() {
    if (_isPressed) {
      return ClipRect(
        child: Align(
          alignment: Alignment(0, -1),
          heightFactor: 0.9,
          child: Image.asset(
            widget.assetName,
            fit: BoxFit.fill,
            height: widget.height ?? 50,
            width: widget.width ?? 50,
          ),
        ),
      );
    } else {
      return Image.asset(
        widget.assetName,
        fit: BoxFit.fill,
        height: widget.height ?? 50,
        width: widget.width ?? 50,
      );
    }
  }
}
