import 'package:flutter/material.dart';

import 'colors.dart';

class AppInputDecorations {
  AppInputDecorations._();

  static InputDecoration inputDecorationEmail = InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2,
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  static InputDecoration inputDecorationPassword = InputDecoration(
    labelText: 'Password',
    hintText: 'Enter your password',
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2,
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
