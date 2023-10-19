part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class AddProductsLoading extends ProductsState {}

final class AddProductsSuccess extends ProductsState {}

final class AddProductsFailure extends ProductsState {
  final String errorMessage;

  const AddProductsFailure({required this.errorMessage});
}

//delete Products:
final class DeleteProductsLoading extends ProductsState {}

final class DeleteProductsSuccess extends ProductsState {}

final class DeleteProductsFailure extends ProductsState {
  final String errorMessage;

  const DeleteProductsFailure({required this.errorMessage});
}

//edit Products:
final class EditProductsLoading extends ProductsState {}

final class EditProductsSuccess extends ProductsState {}

final class EditProductsFailure extends ProductsState {
  final String errorMessage;

  const EditProductsFailure({required this.errorMessage});
}

//
final class GetProductsLoading extends ProductsState {}

final class GetProductsSuccess extends ProductsState {}

final class GetProductsFailure extends ProductsState {
  final String errorMessage;

  const GetProductsFailure({required this.errorMessage});
}

// image states:
final class ImageSuccess extends ProductsState {}

final class ImageFailure extends ProductsState {}
