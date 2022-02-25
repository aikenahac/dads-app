import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF06185A);
  static const Color secondary = Color(0xFF3451A1);

  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primary,
      Color(0xFF001B7E),
    ],
  );

  static TextStyle textStyle = GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 16,
  );
}
