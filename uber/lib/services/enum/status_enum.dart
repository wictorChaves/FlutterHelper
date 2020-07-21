import 'package:flutter/foundation.dart';

enum StatusEnum { WAIT, ON_MY_WAY, TRAVELING, FINISHED, CANCELED }

describeToEnum(String discribe) {
  return StatusEnum.values.firstWhere(
      (element) => describeEnum(element) == discribe,
      orElse: () => null);
}

enumToDescribe(StatusEnum item) {
  return describeEnum(item);
}
