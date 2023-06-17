import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/model/categorie.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.toggleFavMeals,
    required this.isFavorite,
  });

  final void Function(Meal meal) toggleFavMeals;
  final bool Function(Meal meal) isFavorite;

  void _onSelectCategory(BuildContext context, Category category) {
    final test = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          toggleFavMeals: toggleFavMeals,
          isFavorite: isFavorite,
          title: category.title,
          meals: test,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _onSelectCategory(context, category);
            },
          )
      ],
    );
  }
}