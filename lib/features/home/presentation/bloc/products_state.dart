part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final List<Product> favoriteProducts;
  final bool isLoadingMore;
  final bool hasReachedMax;

  const ProductsLoaded({
    required this.products,
    this.favoriteProducts = const [],
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [
    products,
    favoriteProducts,
    isLoadingMore,
    hasReachedMax,
  ];
}

final class ProductsError extends ProductsState {
  final String message;
  const ProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
