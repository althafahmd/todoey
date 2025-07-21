import 'package:flutter/material.dart';

class SmoothTypewriterText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration duration;
  final Duration charDelay;

  const SmoothTypewriterText({
    super.key,
    required this.text,
    required this.textStyle,
    this.duration = const Duration(milliseconds: 1000),
    this.charDelay = const Duration(milliseconds: 60),
  });

  @override
  State<SmoothTypewriterText> createState() => _SmoothTypewriterTextState();
}

class _SmoothTypewriterTextState extends State<SmoothTypewriterText>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    final length = widget.text.length;

    _controllers = List.generate(length, (i) {
      return AnimationController(vsync: this, duration: widget.duration);
    });

    _animations = List.generate(length, (i) {
      return CurvedAnimation(parent: _controllers[i], curve: Curves.easeOut);
    });

    if (length > 0) {
      _startAnimations();
    }
  }

  void _startAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      if (!mounted) return;

      await Future.delayed(widget.charDelay);

      if (!mounted) return;

      _controllers[i].forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(widget.text.length, (i) {
        return FadeTransition(
          opacity: _animations[i],
          child: Text(widget.text[i], style: widget.textStyle),
        );
      }),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.stop();
      controller.dispose();
    }
    super.dispose();
  }
}
