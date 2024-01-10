import 'package:flutter/material.dart';
import 'package:foodcie/models/recipe.api.dart';
import 'package:foodcie/models/recipe.dart';
import 'package:foodcie/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeAPI.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10.0),
              Text('Foodcie'),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                    title: _recipes[index].name,
                    cookTime: _recipes[index].totalTime,
                    rating: _recipes[index].rating.toString(),
                    thumbnailUrl: _recipes[index].images,
                  );
                },
              ));
  }
}
