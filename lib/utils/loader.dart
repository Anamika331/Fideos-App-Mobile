import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:flutter/material.dart';

class Loader {
  show() => CircularProgressIndicator(color: AppColor.primary, strokeWidth: 2);
}
