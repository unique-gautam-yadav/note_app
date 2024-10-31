import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/constants/app_colors.dart';
import 'package:note_app/views/home_view.dart';

/*

  instagram   -     @flutter.demon
  github      -     @unique-gautam-yadav

This is a multiline text in flutter 
You can add text in any way here you can delete any text by dragging the cursor or any thing you can do here like a text editor 

Your you heard it right 


Flutter is love ……………


*/

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.amber,
              surface: AppColors.background,
            ),
            fontFamily: GoogleFonts.rubik().fontFamily,
          ),
          home: const HomeView(),
        );
      },
    );
  }
}
