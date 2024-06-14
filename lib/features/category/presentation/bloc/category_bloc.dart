import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:uptodo/features/category/domain/entity/category.dart';

import 'package:uptodo/features/category/domain/usecases/create_category_usecase.dart';
import 'package:uptodo/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:uptodo/features/category/domain/usecases/update_category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required CreateCategoryUsecase createCategory,
    required GetCategoriesUsecase getCategories,
    required UpdateCategoryUsecase updateCategories,
  })  : _createCategoryUsecase = createCategory,
        _getCategoriesUsecase = getCategories,
        _updateCategoryUsecase = updateCategories,
        super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {});
    on<GetCategoriesEvent>(_getCategories);
    on<UpdateCategoryEvent>(_updateCategory);
    on<CreateCategoryEvent>(_createCategory);
  }

  final CreateCategoryUsecase _createCategoryUsecase;
  final GetCategoriesUsecase _getCategoriesUsecase;
  final UpdateCategoryUsecase _updateCategoryUsecase;

  // @override
  // Future<void> close() {
  //   return super.close();
  // }

  FutureOr<void> _getCategories(GetCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    final result = await _getCategoriesUsecase(event.uid);
    return result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (categoryStream) => emit.forEach(categoryStream, onData: (data) {
        return CategoryLoaded(data);
      }),
    );
  }

  FutureOr<void> _updateCategory(UpdateCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    final result = await _updateCategoryUsecase(event.category);
    return result.fold((failure) => emit(CategoryError(failure.message)), (category) {
      // TODO: Implement Update Category
    });
  }

  FutureOr<void> _createCategory(CreateCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    final result = await _createCategoryUsecase(event.category);
    return result.fold((failure) => emit(CategoryError(failure.message)), (category) {
      // TODO: Implement Create Category
    });
  }
}
