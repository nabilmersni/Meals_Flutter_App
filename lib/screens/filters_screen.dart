import 'package:flutter/material.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filters, bool> currentFilters;
  @override
  State<FiltersScreen> createState() {
    return _FiltersScreen();
  }
}

class _FiltersScreen extends State<FiltersScreen> {
  bool _glutenFreeCheked = false;
  bool _lactoseFreeCheked = false;
  bool _vegetarianCheked = false;
  bool _veganCheked = false;

  @override
  void initState() {
    _glutenFreeCheked = widget.currentFilters[Filters.glutenFree]!;
    _lactoseFreeCheked = widget.currentFilters[Filters.lactoseFree]!;
    _vegetarianCheked = widget.currentFilters[Filters.vegetarian]!;
    _veganCheked = widget.currentFilters[Filters.vegan]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(
            context,
            {
              Filters.glutenFree: _glutenFreeCheked,
              Filters.lactoseFree: _lactoseFreeCheked,
              Filters.vegetarian: _vegetarianCheked,
              Filters.vegan: _veganCheked,
            },
          );
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeCheked,
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              // activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              onChanged: (isChecked) {
                setState(
                  () {
                    _glutenFreeCheked = isChecked;
                  },
                );
              },
            ),
            SwitchListTile(
              value: _lactoseFreeCheked,
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              // activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              onChanged: (isChecked) {
                setState(
                  () {
                    _lactoseFreeCheked = isChecked;
                  },
                );
              },
            ),
            SwitchListTile(
              value: _vegetarianCheked,
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              // activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              onChanged: (isChecked) {
                setState(
                  () {
                    _vegetarianCheked = isChecked;
                  },
                );
              },
            ),
            SwitchListTile(
              value: _veganCheked,
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              // activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              onChanged: (isChecked) {
                setState(
                  () {
                    _veganCheked = isChecked;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
