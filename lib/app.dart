import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sponsors/module/sponsors/view/sponsors_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: const Color(0xFFF9F9F9),
        primarySwatch: Colors.lightGreen,
        fontFamily: GoogleFonts.workSans().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: GoogleFonts.workSans(
            color: Colors.grey.shade900,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          elevation: 1.5,
        ),
      ),
      home: const SponsorsView(),
    );
  }
}
