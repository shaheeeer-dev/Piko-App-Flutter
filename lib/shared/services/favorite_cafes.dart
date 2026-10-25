import 'package:flutter/foundation.dart';

/// Saved cafés shared by Home and café details during the current app session.
class FavoriteCafes {
  static final names = ValueNotifier<Set<String>>({});

  static bool contains(String name) => names.value.contains(name);

  static void toggle(String name) {
    final updated = {...names.value};
    if (!updated.remove(name)) updated.add(name);
    names.value = Set.unmodifiable(updated);
  }
}
