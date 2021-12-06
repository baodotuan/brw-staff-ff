import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import '../../auth/auth_util.dart';

String transactionType(bool creditBool) {
  // Add your function code here!
  if (creditBool) {
    return "thanh toan";
  }
  ;
  if (!creditBool) {
    return 'nap tien';
  }
  ;
  return "error";
}

int getThenAddPoint(
  int currentPoint,
  int newPoint,
  bool creditBool,
) {
  // Add your function code here!
  if (creditBool) {
    return (currentPoint - newPoint);
  }
  ;
  if (!creditBool) {
    return (currentPoint + newPoint);
  }
  ;
}

int stringToInt(String input) {
  // Add your function code here!
  return int.parse(input);
}

bool returnFalseIfNegative(int number) {
  // Add your function code here!
  if (number >= 0) {
    return true;
  } else {
    return false;
  }
}

bool returnFalseIfEmpty(String string) {
  // Add your function code here!
  if (["", null].contains(string)) {
    return false;
  } else {
    return true;
  }
}
