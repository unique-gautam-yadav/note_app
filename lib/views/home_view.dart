import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:note_app/common/scale_button.dart';
import 'package:note_app/constants/app_colors.dart';
import 'package:note_app/constants/app_images.dart';
import 'package:note_app/views/new_note_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selected = "All Notes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: ScaleButton(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const NewNoteView(),
            ),
          );
        },
        scale: .9,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: AppColors.black,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            AppImages.addIcon,
            color: Colors.white,
            width: 44.w,
          ),
        ),
      ),
      body: Stack(
        // fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: SizedBox.fromSize(
              size: MediaQuery.sizeOf(context),
              child: Opacity(
                opacity: .7,
                child: Image.asset(
                  AppImages.bg1,
                  fit: BoxFit.cover,
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                ),
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width -
                  (20.w * 2) -
                  44.w -
                  (24.w * 2) -
                  20.w,
              child: ListView.separated(
                itemCount: 20,
                padding: EdgeInsets.only(
                  top: 360.w + 20.w,
                  bottom: MediaQuery.paddingOf(context).bottom + 20.w,
                ),
                separatorBuilder: (context, index) => SizedBox(height: 20.w),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(24.w),
                    height: MediaQuery.sizeOf(context).width -
                        (20.w * 2) -
                        44.w -
                        (24.w * 2) -
                        20.w +
                        10,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.calendar,
                                color: AppColors.indigo,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                DateFormat('MMM, dd, yyyy').format(
                                  DateTime.now(),
                                ),
                              ),
                              SizedBox(width: 4.w),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "New Metal ✌️ Music to Listen",
                          style: TextStyle(
                            fontSize: 22.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            height: 360.w,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  color: AppColors.background.withOpacity(.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.paddingOf(context).top + 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    AppImages.profile,
                                    width: 45.w,
                                    height: 45.w,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Iconsax.menu_15,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            FractionallySizedBox(
                              widthFactor: .9,
                              child: Text(
                                "Your Thoughts, One Place.",
                                style: TextStyle(
                                  fontSize: 44.sp,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 54.h,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          scrollDirection: Axis.horizontal,
                          children: [
                            _appBarChip('Collections'),
                            _appBarChip('Old Notes'),
                            _appBarChip('All Notes'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
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

  Widget _appBarChip(String title) {
    return ScaleButton(
      onTap: () {
        setState(() {
          selected = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastEaseInToSlowEaseOut,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4),
        decoration: BoxDecoration(
          color: selected == title ? AppColors.black : AppColors.background,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: AppColors.black.withOpacity(selected == title ? 1 : .3),
          ),
        ),
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(
              color: selected == title ? Colors.white : AppColors.black,
              fontSize: 14.sp,
            ),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
