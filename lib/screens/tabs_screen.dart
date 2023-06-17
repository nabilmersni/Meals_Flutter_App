import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  bool _isFavorite(Meal meal) {
    return _favMeals.contains(meal);
  }

  void _toggleFavMeals(Meal meal) {
    _favMeals.contains(meal) ? _favMeals.remove(meal) : _favMeals.add(meal);
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      toggleFavMeals: _toggleFavMeals,
      isFavorite: _isFavorite,
    );
    String activeTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favMeals,
        toggleFavMeals: _toggleFavMeals,
        isFavorite: _isFavorite,
      );
      activeTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _selectPage(index),
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Your Favorites',
          ),
        ],
      ),
    );
  }
}
