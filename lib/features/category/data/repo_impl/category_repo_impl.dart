import 'package:dartz/dartz.dart';
import 'package:uptodo/core/error/exceptions.dart';
import 'package:uptodo/core/error/failure.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/category/data/data_source/category_remote_data_source.dart';
import 'package:uptodo/features/category/data/models/category_model.dart';
import 'package:uptodo/features/category/domain/entity/category.dart';
import 'package:uptodo/features/category/domain/repo/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  CategoryRepoImpl(this._categoryRemoteDataSource);
  final CategoryRemoteDataSource _categoryRemoteDataSource;

  @override
  ResultFuture<Category> createCategory(Category category) async {
    try {
      final result = await _categoryRemoteDataSource.createCategory(CategoryModel.fromCategory(category));
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Stream<List<Category>>> getCategories(String uid) async {
    try {
      return Right(_categoryRemoteDataSource.getCategories(uid));
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Category> getCategoryById(String id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

  @override
  ResultFuture<Category> updateCategory(Category category) async {
    try {
      final result = await _categoryRemoteDataSource.updateCategory(CategoryModel.fromCategory(category));
      return Right(result);
    } on APIException catch (e) {
      return ResultFuture.error(APIFailure.fromException(e));
    }
  }
}
