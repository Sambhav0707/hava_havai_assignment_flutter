part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

final class FetchProducts extends ProductsEvent {}

final class MarkFavProduct extends ProductsEvent {
  final Product product;

  const MarkFavProduct(this.product);

  @override
  List<Object> get props => [product];
}

final class UnmarkFavProduct extends ProductsEvent {
  final Product product;

  const UnmarkFavProduct(this.product);

  @override
  List<Object> get props => [product];
}

final class LoadMoreProducts extends ProductsEvent {}
