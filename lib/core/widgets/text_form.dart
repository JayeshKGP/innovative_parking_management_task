import 'package:flutter/material.dart';
import 'package:innovative_parking_management_task/core/constants/colors.dart';

Widget text_form({
  required String label,
}) {
  return Text(
    label,
    style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 16, fontWeight: FontWeight.w700),
  );
}
