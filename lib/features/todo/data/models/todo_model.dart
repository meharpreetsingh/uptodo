import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.status,
    super.category,
    super.target,
    super.priority,
    required super.createdAt,
    super.updatedAt,
  });

  factory TodoModel.fromSnapshot(Map<String, dynamic> data, String id) {
    return TodoModel(
      id: id,
      title: data['title'],
      description: data['description'],
      status: TodoStatus.values[data['status']],
      category: data['category'],
      priority: data['priority'],
      target: data['target'] != null ? (data['target'] as Timestamp).toDate() : null,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null ? (data['updatedAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status.index,
      'category': category,
      'priority': priority,
      'target': target,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static fromTodo(Todo todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      status: todo.status,
      category: todo.category,
      priority: todo.priority,
      target: todo.target,
      createdAt: todo.createdAt,
      updatedAt: todo.updatedAt,
    );
  }
}
