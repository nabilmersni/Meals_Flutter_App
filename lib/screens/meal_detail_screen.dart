import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';

class MealDetailScreen extends StatefulWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
    required this.toggleFavMeals,
    required this.isFavorite,
  });

  final Meal meal;
  final void Function(Meal meal) toggleFavMeals;
  final bool Function(Meal meal) isFavorite;

  @override
  State<StatefulWidget> createState() {
    return _MealDetailScreen();
  }
}

class _MealDetailScreen extends State<MealDetailScreen> {
  // bool isFavorite = widget.isFavorite(widget.meal);
  bool isFavorite = false;

  @override
  void initState() {
    isFavorite = widget.isFavorite(widget.meal);
    super.initState();
  }

  void _toogleFavorite() {
    setState(
      () {
        isFavorite = !isFavorite;
      },
    );

    widget.toggleFavMeals(widget.meal);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: isFavorite
            ? const Text("meal added to Favorite")
            : const Text("meal deleted from Favorite"),
        duration: const Duration(seconds: 4),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: 'Cancel',
          textColor: Theme.of(context).colorScheme.background,
          onPressed: () {
            setState(
              () {
                isFavorite = !isFavorite;
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: _toogleFavorite,
            icon: isFavorite
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            for (final ingredient in widget.meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(
              height: 26,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            for (final step in widget.meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
