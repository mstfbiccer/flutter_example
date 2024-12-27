import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationNotifier extends StateNotifier<List<String>> {
  NavigationNotifier() : super([]);

  void addScreen(String screenName) {
    state = [...state, screenName];
  }

  void clearScreens() {
    state = [];
  }
}

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, List<String>>(
        (ref) => NavigationNotifier());
