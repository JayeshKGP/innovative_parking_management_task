import 'package:flutter/material.dart';
import 'package:innovative_parking_management_task/core/constants/colors.dart';

Widget customButtonWhiteText({
  required String label,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Color(0xffffffff), fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'PlusJakartaSans'),
    ),
  );
}
