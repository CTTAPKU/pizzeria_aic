import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizzeria_aic/core/constants/app_colors.dart';

class CustomThemeData {
  static ThemeData getAppTheme() {
    return ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: AppColors.darkPrimary),
          color: AppColors.darkSecondaryBackground,
          titleTextStyle: GoogleFonts.montserratAlternates(
            fontSize: 25,
            color: AppColors.darkPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.text),
          bodyMedium: TextStyle(color: AppColors.text),
          bodySmall: TextStyle(color: AppColors.text),
          labelSmall: TextStyle(color: AppColors.text),
          labelLarge: TextStyle(color: AppColors.text),
          labelMedium: TextStyle(color: AppColors.text),
        ),
        fontFamily: GoogleFonts.nunito(
          fontWeight: FontWeight.w700,
        ).fontFamily,
        scaffoldBackgroundColor: AppColors.darkPrimaryBackground,
        navigationBarTheme: NavigationBarThemeData(
            backgroundColor: AppColors.darkSecondaryBackground,
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(
                    color: AppColors.darkPrimaryBackground);
              }
              return const IconThemeData(color: AppColors.darkPrimary);
            }),
            labelTextStyle: WidgetStateProperty.all(
              GoogleFonts.montserratAlternates(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text),
            ),
            indicatorColor: AppColors.darkAccent),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all(
              GoogleFonts.montserratAlternates(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            foregroundColor:
                const WidgetStatePropertyAll<Color>(AppColors.darkPrimary),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              textStyle: WidgetStateProperty.all(
                GoogleFonts.montserratAlternates(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              foregroundColor: const WidgetStatePropertyAll<Color>(
                  AppColors.darkPrimaryBackground),
              backgroundColor:
                  const WidgetStatePropertyAll<Color>(AppColors.darkPrimary)),
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: AppColors.darkPrimary,
          textColor: AppColors.text,
        ),
        menuTheme: const MenuThemeData(
            style: MenuStyle(
          backgroundColor:
              WidgetStatePropertyAll<Color>(AppColors.darkSecondaryBackground),
        )),
        menuButtonTheme: MenuButtonThemeData(
            style: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  GoogleFonts.montserratAlternates(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                foregroundColor:
                    const WidgetStatePropertyAll<Color>(AppColors.text))));
  }
}
