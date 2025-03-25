// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:havahavai_assignment/features/home/presentation/bloc/products_bloc.dart';
// import 'package:havahavai_assignment/features/home/domain/entity/product.dart';
// import 'package:havahavai_assignment/features/home/presentation/screens/cart_pag.dart';
// import 'package:havahavai_assignment/features/home/presentation/widgets/cart_widget.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CataLOgue'),
//         backgroundColor: Color(0xFFFFE6EB),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CartPage()),
//               );
//             },
//             icon: const Icon(Icons.shopping_cart_outlined),
//           ),
//         ],
//       ),
//       body: const ProductsGrid(),
//     );
//   }
// }

// class ProductsGrid extends StatefulWidget {
//   const ProductsGrid({Key? key}) : super(key: key);

//   @override
//   _ProductsGridState createState() => _ProductsGridState();
// }

// class _ProductsGridState extends State<ProductsGrid> {
//   final int _limit = 10; // Number of items to load at a time
//   int _offset = 0; // Current offset for pagination
//   List<Product> _products = []; // List to hold products
//   bool _isLoading = false; // Loading state
//   bool _hasMore = true; // Check if more products are available
//   List<Product> favoriteProducts = []; // Add this line
//   @override
//   void initState() {
//     super.initState();
//     _fetchProducts();
//   }

//   void _fetchProducts() {
//     if (_isLoading || !_hasMore) return; // Prevent multiple requests
//     setState(() {
//       _isLoading = true;
//     });

//     context.read<ProductsBloc>().add(FetchProducts());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ProductsBloc, ProductsState>(
//       listener: (context, state) {
//         if (state is ProductsLoading) {
//           setState(() {
//             _isLoading = true;
//           });
//         } else if (state is ProductsLoaded) {
//           setState(() {
//             _products.addAll(state.products);
//             favoriteProducts = List.from(state.favoriteProducts);
//             _products.addAll(state.products);
//             _offset += _limit; // Update offset
//             _isLoading = false;
//             _hasMore =
//                 state.products.length ==
//                 _limit; // Check if more products are available
//           });
//         } else if (state is ProductsError) {
//           setState(() {
//             _isLoading = false;
//             // Handle error (e.g., show a snackbar)
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(state.message)));
//           });
//         }
//       },
//       child: NotificationListener<ScrollNotification>(
//         onNotification: (scrollInfo) {
//           if (!_isLoading &&
//               _hasMore &&
//               scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//             _fetchProducts(); // Load more products when reaching the end
//           }
//           return false;
//         },
//         child: Scaffold(
//           backgroundColor: Color(0xFFFFE6EB),
//           body: GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.6, // Adjust this ratio as needed
//               mainAxisSpacing: 6,
//               crossAxisSpacing: 8,
//             ),
//             padding: const EdgeInsets.all(8),
//             itemCount: _products.length + (_isLoading ? 1 : 0),
//             itemBuilder: (context, index) {
//               if (index == _products.length) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               final product = _products[index];
//               bool isFavorite = favoriteProducts.contains(product);
//               return CartWidget(
//                 onRemovePressed: (){},
//                 isFavorite: isFavorite,
//                 onAddPressed: () {
//                   if (isFavorite) {
//                     context.read<ProductsBloc>().add(UnmarkFavProduct(product));
//                     setState(() {
//                       isFavorite = false;
//                     });
//                   } else {
//                     context.read<ProductsBloc>().add(MarkFavProduct(product));
//                     setState(() {
//                       isFavorite = true;
//                     });
//                   }
//                 },
//                 discountPercentage: product.discountPercentage,
//                 productName: product.title,
//                 brand: product.category,
//                 originalPrice: product.price,
//                 discountedPrice: calculateDiscountedPrice(
//                   product.price,
//                   product.discountPercentage,
//                 ),
//                 imageUrl: product.thumbnail,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// double calculateDiscountedPrice(
//   double originalPrice,
//   double discountPercentage,
// ) {
//   // Calculate the discount amount
//   double discountAmount = (originalPrice * discountPercentage) / 100;
//   // Subtract the discount from the original price
//   double discountedPrice = originalPrice - discountAmount;
//   // Round to 2 decimal places to avoid floating-point precision issues
//   return double.parse(discountedPrice.toStringAsFixed(2));
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:havahavai_assignment/features/home/presentation/bloc/products_bloc.dart';
import 'package:havahavai_assignment/features/home/domain/entity/product.dart';
import 'package:havahavai_assignment/features/home/presentation/screens/cart_pag.dart';
import 'package:havahavai_assignment/features/home/presentation/widgets/cart_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CataLOgue'),
        backgroundColor: Color(0xFFFFE6EB),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              Positioned(
                top: 7,
                right: 10,
                child: Container(
                  width: 15, // Adjusted container width
                  height: 15, // Adjusted container height
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsLoading) {
                        return const Center(
                          // Center the text
                          child: Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10, // Adjusted font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      if (state is ProductsLoaded) {
                        return Center(
                          // Center the text
                          child: Text(
                            state.favoriteProducts.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10, // Adjusted font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      return Center(
                        // Center the text
                        child: Text(
                          "0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10, // Adjusted font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: const ProductsGrid(),
    );
  }
}

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(FetchProducts());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductsBloc>().add(LoadMoreProducts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductsError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is ProductsLoaded) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFE6EB),
            body: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                mainAxisSpacing: 6,
                crossAxisSpacing: 8,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: state.products.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.products.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final product = state.products[index];
                final isFavorite = state.favoriteProducts.any(
                  (p) => p.id == product.id,
                );

                return CartWidget(
                  onRemovePressed: () {
                    context.read<ProductsBloc>().add(UnmarkFavProduct(product));
                  },
                  isFavorite: isFavorite,
                  onAddPressed: () {
                    context.read<ProductsBloc>().add(MarkFavProduct(product));
                  },
                  discountPercentage: product.discountPercentage,
                  productName: product.title,
                  brand: product.category,
                  originalPrice: product.price,
                  discountedPrice: calculateDiscountedPrice(
                    product.price,
                    product.discountPercentage,
                  ),
                  imageUrl: product.thumbnail,
                );
              },
            ),
          );
        }

        return const Center(child: Text('No products found'));
      },
    );
  }
}

double calculateDiscountedPrice(
  double originalPrice,
  double discountPercentage,
) {
  double discountAmount = (originalPrice * discountPercentage) / 100;
  double discountedPrice = originalPrice - discountAmount;
  return double.parse(discountedPrice.toStringAsFixed(2));
}
