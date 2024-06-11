import 'package:uptodo/core/usecase/usecase.dart';
import 'package:uptodo/core/util/typedef.dart';
import 'package:uptodo/features/category/domain/entity/category.dart';
import 'package:uptodo/features/category/domain/repo/category_repo.dart';

class CreateCategoryUsecase extends UsecaseWithParams<void, Category> {
  final CategoryRepo _repo;
  CreateCategoryUsecase(this._repo);

  @override
  ResultFuture<Category> call(Category params) => _repo.createCategory(params);
}
