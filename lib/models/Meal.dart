class Meal {
  final String name;
  final String image;
  final String id;

  Meal({
    required this.name,
    required this.image,
    required this.id,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['strMeal'] ?? '',
      image: json['strMealThumb'] ?? '',
      id: json['idMeal'] ?? '',
    );
  }
}
