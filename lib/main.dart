import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/services/generator.dart';

void main() {
  Generator().generateWordOfTheDay();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.isNotEmpty) {
                    switch (states.first) {
                      case MaterialState.hovered:
                        return Colors.blue;
                      default:
                        break;
                    }
                  }
                  return null;
                },
              ),
              overlayColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.isNotEmpty) {
                    switch (states.first) {
                      case MaterialState.pressed:
                        return Colors.white.withOpacity(0.2);
                      default:
                        break;
                    }
                  }
                  return null;
                },
              ),
              foregroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.isNotEmpty) {
                    switch (states.first) {
                      case MaterialState.hovered:
                        return Colors.white;
                      default:
                        break;
                    }
                  }
                  return null;
                },
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          )),
    ),
  );
}
