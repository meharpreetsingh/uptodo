import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/features/todo/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Stream<List<TodoModel>> getTodos(String uid);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<TodoModel> createTodo(TodoModel todo);
  Future<TodoModel> getTodoById(String id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  TodoRemoteDataSourceImpl(this.firestore, this.auth);
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

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

  @override
  Future<TodoModel> createTodo(TodoModel todo) async {
    try {
      final newTodo = todo.toMap();
      newTodo["uid"] = auth.currentUser!.uid;
      final todoCollection = firestore.collection('todo');
      await todoCollection.doc(todo.id).set(newTodo);
      return getTodoById(todo.id);
    } catch (e) {
      throw const APIException(message: "Unable to create Todo", statusCode: 404);
    }
  }

  @override
  Future<TodoModel> getTodoById(String id) async {
    try {
      final todoCollection = firestore.collection('todo');
      final todo = await todoCollection.doc(id).get().then((doc) => TodoModel.fromSnapshot(doc.data()!, doc.id));
      return todo;
    } catch (e) {
      throw APIException(message: "Unable to get Todo: $id", statusCode: 404);
    }
  }
}
