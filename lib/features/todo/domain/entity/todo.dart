enum TodoStatus { notCompleted, completed, deleted, archived }

class Todo {
  final String id;
  final String title;
  final String description;
  final TodoStatus status;
  final int? priority;
  final String? category;
  final DateTime? target;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.priority,
    this.category,
    this.target,
    required this.createdAt,
    this.updatedAt,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    TodoStatus? status,
    int? priority,
    String? category,
    DateTime? target,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      target: target ?? this.target,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
