part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class AddCategoriesLoading extends CategoriesState {}

final class AddCategoriesSuccess extends CategoriesState {}

final class AddCategoriesFailure extends CategoriesState {
  final String errorMessage;

  const AddCategoriesFailure({required this.errorMessage});
}

//delete Categories:
final class DeleteCategoriesLoading extends CategoriesState {}

final class DeleteCategoriesSuccess extends CategoriesState {}

final class DeleteCategoriesFailure extends CategoriesState {
  final String errorMessage;

  const DeleteCategoriesFailure({required this.errorMessage});
}
//edit Categories:
final class EditCategoriesLoading extends CategoriesState {}

final class EditCategoriesSuccess extends CategoriesState {}

final class EditCategoriesFailure extends CategoriesState {
  final String errorMessage;

  const EditCategoriesFailure({required this.errorMessage});
}

//
final class GetCategoriesLoading extends CategoriesState {}

final class GetCategoriesSuccess extends CategoriesState {}

final class GetCategoriesFailure extends CategoriesState {
  final String errorMessage;

  const GetCategoriesFailure({required this.errorMessage});
}
// image states:
final class ImageSuccess extends CategoriesState {}
final class ImageFailure extends CategoriesState {}


