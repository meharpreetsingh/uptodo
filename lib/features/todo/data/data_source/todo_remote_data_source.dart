import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/features/todo/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Stream<List<TodoModel>> getTodos(String uid);
  Future<TodoModel> updateTodo(TodoModel todo);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  TodoRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Stream<List<TodoModel>> getTodos(String uid) {
    try {
      if (uid.isEmpty) {
        throw const APIException(message: "User ID is required", statusCode: 400);
      }
      final todoCollection = firestore.collection('todo');
      final userTodos = todoCollection.where('uid', isEqualTo: uid);
      return userTodos
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => TodoModel.fromSnapshot(doc.data(), doc.id)).toList());
    } catch (e) {
      throw const APIException(message: "Unable to get stream of Todo", statusCode: 404);
    }
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    try {
      final todoCollection = firestore.collection('todo');
      final result = todoCollection.doc(todo.id).update(todo.toMap()).then((_) => todo);
      return result;
    } catch (e) {
      throw APIException(message: "Unable to update Todo: ${todo.id}", statusCode: 404);
    }
  }
}
