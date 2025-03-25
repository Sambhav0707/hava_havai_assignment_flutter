import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:havahavai_assignment/core/pref%20utils/pref_utils.dart';
import 'package:havahavai_assignment/core/usecase/usecase.dart';
import 'package:havahavai_assignment/features/home/domain/entity/product.dart';
import 'package:havahavai_assignment/features/home/domain/usecases/get_products.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProducts;
  List<Product> _products = [];
  List<int> _favoriteProductIds = [];
  int _currentPage = 0;
  static const int _pageSize = 10;
  List<Product> _allProducts = []; // Store all products

  ProductsBloc({required this.getProducts}) : super(ProductsInitial()) {
    _favoriteProductIds = PrefUtils.getFavoriteProducts();

    on<FetchProducts>(_fetchProducts);
    on<LoadMoreProducts>(_loadMoreProducts);
    on<MarkFavProduct>(_markFav);
    on<UnmarkFavProduct>(_unmarkFav);
  }

  Future<void> _unmarkFav(
    UnmarkFavProduct event,
    Emitter<ProductsState> emit,
  ) async {
    _favoriteProductIds.remove(event.product.id);
    // Save updated list to storage
    await PrefUtils.saveFavoriteProducts(_favoriteProductIds);
    _emitLoadedState(emit);
  }

  Future<void> _markFav(
    MarkFavProduct event,
    Emitter<ProductsState> emit,
  ) async {
    if (!_favoriteProductIds.contains(event.product.id)) {
      _favoriteProductIds.add(event.product.id);
      // Save updated list to storage
      await PrefUtils.saveFavoriteProducts(_favoriteProductIds);
    }
    _emitLoadedState(emit);
  }

  void _emitLoadedState(Emitter<ProductsState> emit) {
    final favoriteProducts =
        _products
            .where((product) => _favoriteProductIds.contains(product.id))
            .toList();

    emit(
      ProductsLoaded(
        products: _products,
        favoriteProducts: favoriteProducts,
        hasReachedMax: false,
        isLoadingMore: false,
      ),
    );
  }

  Future<void> _fetchProducts(
    FetchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      emit(ProductsLoading());
      final result = await getProducts(NoParams());

      result.fold(
        (failure) {
          emit(ProductsError(message: failure.message));
        },
        (success) {
          debugPrint(success.length.toString());
          _allProducts = success; // Store all products
          _products = success.take(_pageSize).toList(); // Take first 10
          final hasReachedMax = _products.length >= _allProducts.length;

          emit(
            ProductsLoaded(
              products: _products,
              favoriteProducts:
                  _products
                      .where(
                        (product) => _favoriteProductIds.contains(product.id),
                      )
                      .toList(),
              hasReachedMax: hasReachedMax,
              isLoadingMore: false,
            ),
          );
        },
      );
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }

  Future<void> _loadMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductsState> emit,
  ) async {
    if (state is! ProductsLoaded) return;
    final currentState = state as ProductsLoaded;
    if (currentState.hasReachedMax) return;

    try {
      emit(
        ProductsLoaded(
          products: currentState.products,
          favoriteProducts: currentState.favoriteProducts,
          isLoadingMore: true,
          hasReachedMax: false,
        ),
      );

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      _currentPage++;
      final startIndex = _currentPage * _pageSize;

      // Check if we've reached the end of available products
      if (startIndex >= _allProducts.length) {
        emit(
          ProductsLoaded(
            products: _products,
            favoriteProducts: _getFavoriteProducts(),
            hasReachedMax: true,
            isLoadingMore: false,
          ),
        );
        return;
      }

      // Get exactly next 10 products
      final newProducts =
          _allProducts.skip(startIndex).take(_pageSize).toList();

      _products = [
        ..._products,
        ...newProducts,
      ]; // Use spread operator to add new products

      // Check if we've reached the end
      final hasReachedMax = startIndex + _pageSize >= _allProducts.length;

      emit(
        ProductsLoaded(
          products: _products,
          favoriteProducts: _getFavoriteProducts(),
          hasReachedMax: hasReachedMax,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }

  List<Product> _getFavoriteProducts() {
    return _products
        .where((product) => _favoriteProductIds.contains(product.id))
        .toList();
  }
}
