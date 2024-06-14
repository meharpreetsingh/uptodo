part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  CategoryLoaded(this.categories);
}

final class CategoryLoading extends CategoryState {}

final class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}
