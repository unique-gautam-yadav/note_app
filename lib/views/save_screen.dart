import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note_app/common/scale_button.dart';
import 'package:note_app/constants/app_colors.dart';
import 'package:note_app/constants/app_images.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 270.h),
                Row(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 170.h, left: 16.w),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                        itemBuilder: (context, index) {
                          return ScaleButton(
                            padding: EdgeInsets.zero,
                            onTap: () {
                              selected = '1_$index';
                              setState(() {});
                            },
                            child: SizedBox(
                              height: 150.h,
                              child: Stack(
                                children: [
                                  AnimatedScale(
                                    scale: selected == '1_$index' ? 2 : 0,
                                    duration: const Duration(microseconds: 300),
                                    curve: Curves.fastEaseInToSlowEaseOut,
                                    child: Image.asset(AppImages.circles),
                                  ),
                                  _collectionCard(
                                      isDark: selected == '1_$index'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                          right: 16.w,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                        itemBuilder: (context, index) {
                          return ScaleButton(
                            padding: EdgeInsets.zero,
                            onTap: () {
                              selected = '2_$index';
                              setState(() {});
                            },
                            child: SizedBox(
                              height: 150.h,
                              child: Stack(
                                children: [
                                  AnimatedScale(
                                    scale: selected == '2_$index' ? 2 : 0,
                                    duration: const Duration(microseconds: 300),
                                    curve: Curves.fastEaseInToSlowEaseOut,
                                    child: Image.asset(AppImages.circles),
                                  ),
                                  _collectionCard(
                                      isDark: selected == '2_$index'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.paddingOf(context).bottom + 80.h),
              ],
            ),
          ),
          Positioned(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  height: 310.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  color: AppColors.background.withOpacity(.4),
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.paddingOf(context).top + 16.h),
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
                            "SAVE TO",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColors.black.withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Select Note Collection",
                        style: TextStyle(
                          fontSize: 44.sp,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: selected == null ? -80 : 0,
            left: 0.w,
            right: 0.w,
            duration: const Duration(milliseconds: 100),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 20.w,
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.background.withOpacity(.0),
                        AppColors.background.withOpacity(1),
                        AppColors.background.withOpacity(1),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      CupertinoButton(
                        onPressed: () {},
                        child: Text(
                          "Save Anyway Without Collection",
                          style: TextStyle(
                            color: Colors.grey.shade800.withOpacity(.8),
                            decorationColor:
                                Colors.grey.shade800.withOpacity(.8),
                            decorationStyle: TextDecorationStyle.dotted,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: selected != null
                            ? const Offset(0, 0)
                            : const Offset(0, 50),
                        child: ScaleButton(
                          onTap: () {
                            showCupertinoModalPopup(
                              barrierColor:
                                  AppColors.background.withOpacity(.4),
                              context: context,
                              builder: (context) {
                                return const _SavedDialog();
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Iconsax.folder_add,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 12.w),
                                const Text(
                                  "Save to Collection",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.paddingOf(context).bottom + 0.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _collectionCard({bool isDark = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FractionallySizedBox(
            widthFactor: .4,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColors.greyColor.withOpacity(isDark ? .8 : .07),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: 30.h,
            decoration: BoxDecoration(
              color: AppColors.greyColor.withOpacity(isDark ? .8 : .07),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: 100.h,
            padding: EdgeInsets.all(12.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? AppColors.black : Colors.white.withOpacity(.8),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.indigo.withOpacity(isDark ? 1 : .15),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.document_1,
                            color: isDark ? Colors.white : AppColors.indigo,
                            size: 12,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            "3 Notes",
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark ? Colors.white : AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "To-Do-List 📋",
                  style: TextStyle(
                    fontSize: 20,
                    color: isDark ? Colors.white : AppColors.black,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedDialog extends StatelessWidget {
  const _SavedDialog();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: SizedBox(
        height: 500,
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            height: 500.h,
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 10.h,
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 30.w,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 450,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          AppImages.success,
                          width: 300,
                        ),
                      ),
                      Positioned.fill(
                        child: Column(
                          children: [
                            const Spacer(),
                            Text(
                              "Successfully Saved!",
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Woohoo!! You saved this note on\n\"To-Do-List\" Collection",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 30),
                            ScaleButton(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 18.h),
                                decoration: BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Iconsax.home_2,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 12.w),
                                    const Text(
                                      "Back to Home",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
