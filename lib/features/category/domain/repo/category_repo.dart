import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/category/domain/entity/category.dart';

abstract class CategoryRepo {
  ResultFuture<Stream<List<Category>>> getCategories(String uid);
  ResultFuture<Category> getCategoryById(String id);
  ResultFuture<Category> updateCategory(Category category);
  ResultFuture<Category> createCategory(Category category);
}
