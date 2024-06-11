import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/category/domain/entity/category.dart';
import 'package:uptodo/features/category/domain/repo/category_repo.dart';

class UpdateCategoryUsecase extends UsecaseWithParams<Category, Category> {
  final CategoryRepo _repo;
  UpdateCategoryUsecase(this._repo);

  @override
  ResultFuture<Category> call(Category params) => _repo.updateCategory(params);
}
