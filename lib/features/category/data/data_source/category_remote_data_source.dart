import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/features/category/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Stream<List<CategoryModel>> getCategories(String uid);
  Future<CategoryModel> updateCategory(CategoryModel category);
  Future<CategoryModel> createCategory(CategoryModel category);
  Future<CategoryModel> getCategoryById(String id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  CategoryRemoteDataSourceImpl(this.firestore, this.auth);
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  @override
  Stream<List<CategoryModel>> getCategories(String uid) {
    try {
      if (uid.isEmpty) {
        throw const APIException(message: "User ID is required", statusCode: 400);
      }
      final categoryCollection = firestore.collection('category');
      final userCategories = categoryCollection.where('uid', isEqualTo: uid);
      return userCategories
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc.data(), doc.id)).toList());
    } catch (e) {
      throw const APIException(message: "Unable to get stream of Category", statusCode: 404);
    }
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    try {
      final categoryCollection = firestore.collection('category');
      final result = categoryCollection.doc(category.id).update(category.toMap()).then((_) => category);
      return result;
    } catch (e) {
      throw APIException(message: "Unable to update Category: ${category.id}", statusCode: 404);
    }
  }

  @override
  Future<CategoryModel> createCategory(CategoryModel category) async {
    try {
      final newCategory = category.toMap();
      newCategory["uid"] = auth.currentUser!.uid;
      final categoryCollection = firestore.collection('category');
      await categoryCollection.doc(category.id).set(newCategory);
      return getCategoryById(category.id);
    } catch (e) {
      throw const APIException(message: "Unable to create Category", statusCode: 404);
    }
  }

  @override
  Future<CategoryModel> getCategoryById(String id) async {
    try {
      final categoryCollection = firestore.collection('category');
      final category = await categoryCollection.doc(id).get().then((doc) => CategoryModel.fromSnapshot(doc.data()!, doc.id));
      return category;
    } catch (e) {
      throw APIException(message: "Unable to get Category: $id", statusCode: 404);
    }
  }
}
