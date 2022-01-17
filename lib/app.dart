import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sponsors/module/sponsors/repository/sponsors_repository.dart';
import 'package:sponsors/module/sponsors/view/sponsors_view.dart';

class App extends StatelessWidget {
  const App({Key? key, required SponsorsRepository sponsorsRepository})
      : _sponsorsRepository = sponsorsRepository,
        super(key: key);

  final SponsorsRepository _sponsorsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _sponsorsRepository,
      child: MaterialApp(
        title: 'Sponsors',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const SponsorsView(),
      ),
    );
  }
}

ThemeData themeData = ThemeData(
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
);
