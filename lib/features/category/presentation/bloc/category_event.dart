part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class GetCategoriesEvent extends CategoryEvent {
  final String uid;
  GetCategoriesEvent(this.uid);
}

final class UpdateCategoryEvent extends CategoryEvent {
  final Category category;
  UpdateCategoryEvent(this.category);
}

final class CreateCategoryEvent extends CategoryEvent {
  final Category category;
  CreateCategoryEvent(this.category);
}
