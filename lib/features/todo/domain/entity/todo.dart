import 'package:uptodo/features/todo/domain/entity/category.dart';

enum TodoStatus { notCompleted, completed, deleted, archived }

class Todo {
  final String id;
  final String title;
  final String description;
  final TodoStatus status;
  final Category category;
  final DateTime target;
  final DateTime createdAt;
  final DateTime updatedAt;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.category,
    required this.target,
    required this.createdAt,
    required this.updatedAt,
  });
}
