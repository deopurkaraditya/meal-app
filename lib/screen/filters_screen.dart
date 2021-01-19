import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currenValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currenValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Yours Filters'),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final selecetedFilters = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                  };
                  widget.saveFilters(selecetedFilters);
                })
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your meal selection',
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTile(
                    'Gluten-Free', 'Show only gluten-free meals', _glutenFree,
                    (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian', 'Show only vegetarian meals', _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildSwitchListTile('Vegan', 'Show only vegan meals', _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                _buildSwitchListTile('Lactose-Free',
                    'Show only lactose-free meals', _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
              ],
            ))
          ],
        ));
  }
}
