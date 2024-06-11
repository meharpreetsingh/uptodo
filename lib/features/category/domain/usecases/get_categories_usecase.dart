import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/category/domain/entity/category.dart';
import 'package:uptodo/features/category/domain/repo/category_repo.dart';

class GetCategoriesUsecase extends UsecaseWithParams<Stream<List<Category>>, String> {
  final CategoryRepo _repo;
  GetCategoriesUsecase(this._repo);

  @override
  ResultFuture<Stream<List<Category>>> call(String params) => _repo.getCategories(params);
}

class GetCategoryByIdUsecase extends UsecaseWithParams<Category, String> {
  final CategoryRepo _repo;
  GetCategoryByIdUsecase(this._repo);

  @override
  ResultFuture<Category> call(String params) => _repo.getCategoryById(params);
}
