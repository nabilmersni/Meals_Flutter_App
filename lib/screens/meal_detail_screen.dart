import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/providers/favorite_meals_provider.dart';

class MealDetailScreen extends ConsumerStatefulWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  ConsumerState<MealDetailScreen> createState() {
    return _MealDetailScreen();
  }
}

class _MealDetailScreen extends ConsumerState<MealDetailScreen> {
  // bool isFavorite = widget.isFavorite(widget.meal);
  bool isAdded = false;

  @override
  void initState() {
    isAdded = ref.read(favMealsProvider).contains(widget.meal);
    super.initState();
  }

  // @override
  // void initState() {
  //   isFavorite = widget.isFavorite(widget.meal);
  //   super.initState();
  // }

  void _toogleFavorite() {
    setState(
      () {
        isAdded =
            ref.read(favMealsProvider.notifier).toggleFavoriteMeal(widget.meal);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: isAdded
            ? const Text("meal added to Favorite")
            : const Text("meal deleted from Favorite"),
        duration: const Duration(seconds: 3),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: 'Cancel',
          textColor: Theme.of(context).colorScheme.background,
          onPressed: () {
            setState(
              () {
                isAdded = ref
                    .read(favMealsProvider.notifier)
                    .toggleFavoriteMeal(widget.meal);
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
            icon: isAdded
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
