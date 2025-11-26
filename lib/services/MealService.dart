import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/Recipe.dart';

class ApiService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['categories'] as List).map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Error loading categories');
    }
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
    } else {
      throw Exception('Error loading meals');
    }
  }

  Future<Recipe> fetchMealDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Recipe.fromJson(data['meals'][0]);
    } else {
      throw Exception('Error loading details');
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
    } else {
      throw Exception('Error during search');
    }
  }

  Future<Meal> fetchRandomMeal() async {
    final response = await http.get(Uri.parse('$baseUrl/random.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Meal.fromJson(data['meals'][0]);
    } else {
      throw Exception('Error loading random recipe');
    }
  }
}
