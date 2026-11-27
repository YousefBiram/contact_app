import 'package:flutter/material.dart';

import '../app_data/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  String text;
  AppTextField({required this.text,required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 60,
      child: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.white),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight(400),
          ),
          hintText: text,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.gold),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.gold),
          ),
        ),
      ),
    );
  }
}
