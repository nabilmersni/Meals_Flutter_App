import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filters, bool>> {
  FilterNotifier()
      : super(
          {
            Filters.glutenFree: false,
            Filters.lactoseFree: false,
            Filters.vegetarian: false,
            Filters.vegan: false,
          },
        );

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filters, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filters, bool>>(
  (ref) => FilterNotifier(),
);

final filtredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (selectedFilters[Filters.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
