class Recipe {
  final String name;
  final String image;
  final String instructions;
  final List<String> ingredients;
  final String? ytLink;

  Recipe({
    required this.name,
    required this.image,
    required this.instructions,
    required this.ingredients,
    this.ytLink,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add('${ingredient.toString().trim()} (${measure?.toString().trim() ?? ''})');
      }
    }
    return Recipe(
      name: json['strMeal'] ?? '',
      image: json['strMealThumb'] ?? '',
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
      ytLink: json['strYoutube'],
    );
  }
}
