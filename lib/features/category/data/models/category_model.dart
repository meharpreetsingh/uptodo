import 'package:flutter/material.dart';
import 'package:uptodo/features/category/domain/entity/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.foregroundColor,
    required super.backgroundColor,
  });

  factory CategoryModel.fromSnapshot(Map<String, dynamic> data, String id) {
    return CategoryModel(
      id: id,
      name: data["name"],
      foregroundColor: Color(data["foregroundColor"]).withOpacity(1),
      backgroundColor: Color(data["backgroundColor"]).withOpacity(1),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'foregroundColor': foregroundColor.value,
      'backgroundColor': backgroundColor.value,
    };
  }

  factory CategoryModel.fromCategory(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      foregroundColor: category.foregroundColor,
      backgroundColor: category.backgroundColor,
    );
  }
}
