import 'dart:async';

import 'package:flutter/material.dart';

class ScaleButton extends StatefulWidget {
  const ScaleButton({
    super.key,
    required this.onTap,
    required this.child,
    this.scale,
    this.onLongPress,
    this.padding,
    this.opacityButton = false,
    this.onLongPressEnd,
  });

  @override
  State<ScaleButton> createState() => _ScaleButtonState();
  final FutureOr<void> Function()? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onLongPressEnd;
  final Widget child;
  final double? scale;
  final EdgeInsets? padding;
  final bool opacityButton;
}

class _ScaleButtonState extends State<ScaleButton> {
  bool isPressed = false;
  bool loading = false;

  func() async {
    loading = true;
    setState(() {});

    try {
      await widget.onTap?.call();
    } catch (e) {
      //
    }

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.opacityButton
          ? isPressed
              ? .6
              : 1
          : isPressed
              ? (widget.scale ?? .97)
              : 1,
      duration: const Duration(milliseconds: 50),
      child: AnimatedScale(
        scale: isPressed ? (widget.scale ?? .97) : 1,
        duration: const Duration(milliseconds: 100),
        child: GestureDetector(
          onTap: widget.onTap == null || loading
              ? null
              : () {
                  if (widget.onTap != null) {
                    setState(() {
                      isPressed = true;
                    });
                    Future.delayed(const Duration(milliseconds: 50))
                        .then((value) {
                      setState(() {
                        isPressed = false;
                      });
                      func();
                    });
                  }
                },
          onTapDown: (_) {
            if (widget.onTap != null && loading != true) {
              setState(() {
                isPressed = true;
              });
            }
          },
          onLongPress: () {
            if (widget.onLongPress != null && loading != true) {
              setState(() {
                isPressed = true;
              });
            }

            widget.onLongPress?.call();
          },
          onLongPressCancel: () {
            if (widget.onLongPress != null && loading != true) {
              setState(() {
                isPressed = false;
              });
            }

            widget.onLongPressEnd?.call();
          },
          onLongPressEnd: (_) {
            if (widget.onLongPress != null && loading != true) {
              setState(() {
                isPressed = false;
              });
            }

            widget.onLongPressEnd?.call();
          },
          onTapUp: (_) {
            if (widget.onTap != null && loading != true) {
              setState(() {
                isPressed = false;
              });
            }
          },
          onTapCancel: () {
            if (widget.onTap != null && loading != true) {
              setState(() {
                isPressed = false;
              });
            }
          },
          child: Container(
            color: Colors.transparent,
            padding: widget.padding ?? const EdgeInsets.all(8),
            child: AnimatedOpacity(
              opacity: loading ? .5 : 1,
              duration: const Duration(milliseconds: 300),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
