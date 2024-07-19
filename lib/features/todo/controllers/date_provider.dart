import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'date_provider.g.dart';

@riverpod
class DateState extends _$DateState {
  @override
  String build() {
    return '';
  }

  void setDate(String newState) {
    state = newState;
  }
}

@riverpod
class StartTimeState extends _$StartTimeState {
  @override
  String build() {
    return '';
  }

  void setStart(String newState) {
    state = newState;
  }

  List<int> dates(DateTime startDate) {
    DateTime now = DateTime.now();
    Duration difference = startDate.difference(now);
    log(startDate.toString());
    return [
      difference.inDays,
      difference.inHours % 24,
      difference.inMinutes % 60,
      difference.inSeconds % 60,
    ];
  }
}

@riverpod
class EndTimeState extends _$EndTimeState {
  @override
  String build() {
    return '';
  }

  void setEnd(String newState) {
    state = newState;
  }
}
