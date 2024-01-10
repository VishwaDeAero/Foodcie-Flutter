import 'dart:convert';

import 'package:foodcie/constants.dart' as constants;
import 'package:foodcie/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeAPI {
  static Future<List<Recipe>> getRecipe() async {
    List _temp = [];

    // Yummly API
    var uri = Uri.https(
      'yummly2.p.rapidapi.com',
      '/feeds/list',
      {"limit": "18", "start": "0", "tag": "list.recipe.popular"},
    );

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": constants.RAPID_API_KEY,
      "x-rapidapi-host": constants.RAPID_API_HOST,
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}
