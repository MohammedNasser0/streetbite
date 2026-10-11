import '../../domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel({
    required super.id,
    required super.name,
    required super.category,
    required super.area,
    required super.image,
    required super.instructions,
  });
  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
    id: json['idMeal']?.toString() ?? '',
    name: json['strMeal'] as String? ?? '',
    category: json['strCategory'] as String? ?? '',
    area: json['strArea'] as String? ?? '',
    image: json['strMealThumb'] as String? ?? '',
    instructions: json['strInstructions'] as String? ?? '',
  );
  Map<String, dynamic> toJson() => {
    'idMeal': id,
    'strMeal': name,
    'strCategory': category,
    'strArea': area,
    'strMealThumb': image,
    'strInstructions': instructions,
  };
}
