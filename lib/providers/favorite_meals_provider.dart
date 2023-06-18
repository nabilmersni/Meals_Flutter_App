import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/model/meal.dart';

class FavoriteMealNotfier extends StateNotifier<List<Meal>> {
  FavoriteMealNotfier() : super([]);

  bool toggleFavoriteMeal(Meal meal) {
    final isFav = state.contains(meal);

    if (isFav) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favMealsProvider = StateNotifierProvider<FavoriteMealNotfier, List<Meal>>(
  (ref) => FavoriteMealNotfier(),
);
