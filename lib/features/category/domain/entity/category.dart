import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final Color foregroundColor;
  final Color backgroundColor;

  const Category({
    required this.id,
    required this.name,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  @override
  List<Object?> get props => [id, name];
}
