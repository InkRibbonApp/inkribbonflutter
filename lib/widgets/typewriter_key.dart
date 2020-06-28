import 'package:flutter/material.dart';

class TypewriterKey extends StatefulWidget {
  TypewriterKey({@required this.assetName, this.height, this.width, this.onTap});

  final double height;
  final double width;
  final Function onTap;
  final String assetName;

  @override
  _TypewriterKeyState createState() => _TypewriterKeyState();
}

class _TypewriterKeyState extends State<TypewriterKey> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          if (!_isPressed) {
            _isPressed = true;
          }
        });
      },
      onTapUp: (details) {
        setState(() {
          if (_isPressed) {
            _isPressed = false;
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
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
