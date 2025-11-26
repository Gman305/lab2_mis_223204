import 'package:flutter/material.dart';
import '../services/MealService.dart';
import '../models/Recipe.dart';

class MealDetailScreen extends StatelessWidget {
  final String mealId;
  const MealDetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return Scaffold(
      appBar: AppBar(title: Text("Meal details")),
      body: FutureBuilder<Recipe>(
        future: apiService.fetchMealDetail(mealId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final meal = snapshot.data;
          if (meal == null) return Center(child: Text('Meal not found.'));
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(meal.image),
                SizedBox(height: 12),
                Text(meal.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Instructions:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(meal.instructions ?? ''),
                SizedBox(height: 10),
                Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...meal.ingredients.map((i) => Text(i)),
                SizedBox(height: 12),
                if (meal.ytLink != null && meal.ytLink!.isNotEmpty)
                  InkWell(
                    child: Text('Watch video', style: TextStyle(color: Colors.blue)),
                    onTap: () {
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
