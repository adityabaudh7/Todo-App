import 'package:flutter_riverpod/flutter_riverpod.dart';

final radioProvider = StateProvider<int>((ref) {
  return 0;
});

final selectedReminderProvider = StateProvider<String>((ref) => 'select');

final selectedRepeatProvider = StateProvider<String>((ref) => 'select');

final greetingProvider = Provider<String>((ref) {
  final now = DateTime.now();
  final hour = now.hour;

  if (hour < 12) {
    return 'Good morning!';
  } else if (hour < 17) {
    return 'Good afternoon!';
  } else {
    return 'Good evening!';
  }
});
