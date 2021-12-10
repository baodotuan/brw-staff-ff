import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import '../../auth/auth_util.dart';

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

int addOrSubstractTwoInteger(
  int input1,
  int input2,
  bool add,
) {
  // Add your function code here!
  if (add) {
    return input1 + input2;
  } else {
    return input1 - input2;
  }
}

int setLimitToInterger(
  int input,
  int limit,
) {
  // Add your function code here!
  try {
    if (input > limit) {
      return limit;
    } else {
      return input;
    }
  } catch (e) {
    return input;
  }
}
