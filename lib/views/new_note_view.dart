import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note_app/common/scale_button.dart';
import 'package:note_app/constants/app_colors.dart';
import 'package:note_app/constants/app_images.dart';
import 'package:note_app/views/save_screen.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({super.key});

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  TextEditingController? focusedController;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();
  final FocusNode _titleNode = FocusNode();
  final FocusNode _contentNode = FocusNode();
  int isCap = 1;

  Timer? _longTimer;

  startBack() {
    _longTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (focusedController == null) {
        _longTimer?.cancel();
        return;
      }
      String c = focusedController!.text;
      if (c.isEmpty) return;

      String cont = focusedController!.text;
      int ind = focusedController!.selection.baseOffset;

      String n = cont.substring(0, ind);
      n = n.substring(0, n.length - 1);

      if (n.isEmpty) {
        _longTimer?.cancel();
      }

      String m = cont.substring(ind, cont.length);

      focusedController?.text = "$n$m";

      focusedController!.selection =
          TextSelection.fromPosition(TextPosition(offset: ind - 1));
    });
  }

  startForward(String key) {
    _longTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (focusedController == null) {
        _longTimer?.cancel();
        return;
      }
      if (isCap == 0 && key.length == 1) {
        key = key.toLowerCase();
      }

      if (isCap == 1) {
        setState(() {
          isCap = 0;
        });
      }

      String cont = focusedController!.text;
      int ind = focusedController!.selection.baseOffset;

      String n = cont.substring(0, ind);
      String m = cont.substring(ind, cont.length);

      focusedController?.text = "$n$key$m";
      focusedController!.selection =
          TextSelection.fromPosition(TextPosition(offset: ind + 1));
    });
  }

  @override
  void initState() {
    super.initState();

    _titleNode.addListener(() {
      if (_titleNode.hasFocus) {
        isCap = _title.text.isEmpty ? 1 : 0;

        focusedController = _title;
        setState(() {});
      } else {
        if (focusedController == _title) {
          focusedController = null;
          setState(() {});
        }
      }
    });

    _contentNode.addListener(() {
      if (_contentNode.hasFocus) {
        isCap = _content.text.isEmpty ? 1 : 0;

        focusedController = _content;

        setState(() {});
      } else {
        if (focusedController == _content) {
          focusedController = null;
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.bg2,
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          Positioned.fill(
            left: 20.w,
            right: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.paddingOf(context).top + 16.h),
                Row(
                  children: [
                    ScaleButton(
                      scale: .9,
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Iconsax.arrow_left),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Text(
                      "ADD NOTE",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.black.withOpacity(.5),
                      ),
                    ),
                    const Spacer(),
                    ScaleButton(
                      scale: .9,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const SaveScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 18.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.folder_add,
                              size: 26,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              "SAVE",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.none,
                          maxLines: 100,
                          minLines: 1,
                          focusNode: _titleNode,
                          controller: _title,
                          cursorColor: AppColors.black,
                          style: TextStyle(
                            fontSize: 44.sp,
                            color: AppColors.black,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Add Title",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.zero,
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.none,
                          maxLines: 100,
                          minLines: 1,
                          focusNode: _contentNode,
                          controller: _content,
                          cursorColor: AppColors.black,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.black,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Add Content",
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                  width: double.infinity,
                  height: focusedController == null ? 0 : 300.h,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastEaseInToSlowEaseOut,
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            left: 4.w,
            right: 4.w,
            bottom: focusedController == null ? -300.h : 4.w,
            curve: Curves.fastEaseInToSlowEaseOut,
            child: Container(
              padding: EdgeInsets.only(
                left: 6.w,
                right: 6.w,
                top: 6.w,
                bottom: MediaQuery.paddingOf(context).bottom + 6.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                  bottom: Radius.circular(60),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      ScaleButton(
                        onTap: () {
                          primaryFocus?.unfocus();
                        },
                        child: const Icon(
                          Iconsax.arrow_down_1,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _key("Q"),
                      _key("W"),
                      _key("E"),
                      _key("R"),
                      _key("T"),
                      _key("Y"),
                      _key("U"),
                      _key("I"),
                      _key("O"),
                      _key("P"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _key("A"),
                      _key("S"),
                      _key("D"),
                      _key("F"),
                      _key("G"),
                      _key("H"),
                      _key("J"),
                      _key("K"),
                      _key("L"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _stringFlexKey("shift", 1),
                      _key("Z"),
                      _key("X"),
                      _key("C"),
                      _key("V"),
                      _key("B"),
                      _key("N"),
                      _key("M"),
                      _stringFlexKey("DEL", 1),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _stringFlexKey(
                        "ABC",
                        1,
                        radius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(24),
                        ),
                      ),
                      _stringFlexKey("space", 3),
                      _stringFlexKey(
                        "return",
                        1,
                        radius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(24),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stringFlexKey(
    String key,
    int flex, {
    BorderRadius? radius,
  }) {
    return Expanded(
      flex: flex,
      child: _key(key),
    );
  }

  Widget _key(String key) {
    return ScaleButton(
      opacityButton: true,
      onLongPressEnd: () {
        if (_longTimer?.isActive ?? false) {
          _longTimer?.cancel();
        }
      },
      onLongPress: () {
        if (key == 'DEL') {
          startBack();
        }

        if (key.length == 1) {
          startForward(key);
        }
      },
      onTap: () {
        if (isCap == 0 && key.length == 1) {
          key = key.toLowerCase();
        }

        if (isCap == 1) {
          setState(() {
            isCap = 0;
          });
        }

        if (key == 'space') {
          _add(' ');
        }
        if (key == 'DEL') {
          _delete();
        }

        if (key == 'return') {
          _add('\n');
        }

        if (key == 'shift') {
          isCap = isCap == -1
              ? 0
              : isCap == 1
                  ? 0
                  : isCap == 0
                      ? 1
                      : isCap;
          setState(() {});
        }

        if (key == 'ABC') {
          isCap = isCap == -1 ? 0 : -1;
          setState(() {});
        }
        if (key.length == 1) {
          _add(key);
        }
      },
      padding: EdgeInsets.zero,
      child: Container(
        margin: const EdgeInsets.all(2),
        height: 45,
        width: (MediaQuery.sizeOf(context).width - ((6.w * 4) + 4 * 10)) / 10,
        decoration: BoxDecoration(
          color: (key == 'shift' && isCap == 1) || (key == 'ABC' && isCap == -1)
              ? Colors.blue
              : Colors.white.withOpacity(.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            key.length == 1
                ? (isCap != 0)
                    ? key.toUpperCase()
                    : key.toLowerCase()
                : key,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _add(String key) {
    String cont = focusedController!.text;
    int ind = focusedController!.selection.baseOffset;

    String n = cont.substring(0, ind);
    String m = cont.substring(ind, cont.length);

    focusedController?.text = "$n$key$m";
    focusedController!.selection =
        TextSelection.fromPosition(TextPosition(offset: ind + 1));
  }

  void _delete() {
    int st = focusedController!.selection.start;
    int end = focusedController!.selection.end;

    String cont = focusedController!.text;
    int ind = focusedController!.selection.baseOffset;
    if (cont.isNotEmpty) {
      if (st != end) {
        focusedController!.text =
            cont.substring(0, st) + cont.substring(end, cont.length);
        focusedController!.selection =
            TextSelection.fromPosition(TextPosition(offset: ind));
      } else {
        String n = cont.substring(0, ind);
        n = n.substring(0, n.length - 1);
        String m = cont.substring(ind, cont.length);

        focusedController?.text = "$n$m";
        focusedController!.selection =
            TextSelection.fromPosition(TextPosition(offset: ind - 1));
      }
    }
  }
}
