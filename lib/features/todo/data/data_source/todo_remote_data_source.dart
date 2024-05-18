import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/features/todo/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Stream<List<TodoModel>> getTodos(String uid);
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
}
