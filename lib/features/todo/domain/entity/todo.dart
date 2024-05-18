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
}
