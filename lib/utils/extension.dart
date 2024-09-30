import 'package:flutter/material.dart';
import 'package:house_rent/domain/models/tenant_model.dart';
import 'package:intl/intl.dart';

extension TimeStamp on int {
  String formatDate() {
    return DateFormat("dd/MM/yyyy")
        .format(DateTime.fromMicrosecondsSinceEpoch(this * 1000));
  }
}

extension CustomTextStyle on TextStyle {
  TextStyle get boldTitle =>
      copyWith(fontWeight: FontWeight.bold, fontSize: 22);

  TextStyle get textButtonStyle => copyWith(fontSize: 16);
}