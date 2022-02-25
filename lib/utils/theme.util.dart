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

  static const inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    focusColor: AppTheme.primary,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppTheme.primary, width: 2.0),
    ),
  );

  static final loginInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    fillColor: AppTheme.primary,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 2.0,
      ),
    ),
  );
}
