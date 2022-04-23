import 'package:flutter/material.dart';
import 'package:wordle/app/widgets/virtual_keyboard_controller.dart';

class VirtualKeyButton extends StatefulWidget {
  final Widget child;
  final VirtualKeyboardController controller;
  final Size size;
  final Color Function()? backgroundColor;
  final Curve curve;
  final Duration duration;
  final EdgeInsets margin;
  final VoidCallback? onPressed;

  const VirtualKeyButton({
    Key? key,
    required this.child,
    required this.controller,
    required this.size,
    this.backgroundColor,
    this.duration = Duration.zero,
    this.curve = Curves.ease,
    this.margin = EdgeInsets.zero,
    this.onPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VirtualKeyButtonState();
}

class _VirtualKeyButtonState extends State<VirtualKeyButton> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.size.height,
      width: widget.size.width,
      margin: widget.margin,
      color: (widget.backgroundColor == null)
          ? Colors.transparent
          : widget.backgroundColor!(),
      duration: widget.duration,
      curve: widget.curve,
      child: OutlinedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.isNotEmpty) {
              switch (states.first) {
                case MaterialState.pressed:
                  return Colors.blue.withOpacity(0.3);
                default:
                  break;
              }
            }
            return Colors.transparent;
          }),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          side: MaterialStateProperty.resolveWith((states) {
            late var color = Colors.grey.shade300;
            if (states.isNotEmpty) {
              final state = states.first;
              if (state == MaterialState.hovered ||
                  state == MaterialState.pressed) {
                color = Colors.black;
              }
            }
            return BorderSide(color: color, width: 1);
          }),
        ),
        child: FittedBox(
          fit: BoxFit.cover,
          child: widget.child,
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
