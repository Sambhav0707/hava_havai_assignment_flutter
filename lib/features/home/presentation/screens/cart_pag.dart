import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:havahavai_assignment/core/pref%20utils/pref_utils.dart';
import 'package:havahavai_assignment/features/home/domain/entity/product.dart';
import 'package:havahavai_assignment/features/home/presentation/bloc/products_bloc.dart';
import 'package:havahavai_assignment/features/home/presentation/widgets/cart_widget.dart';
import 'package:havahavai_assignment/features/home/presentation/widgets/fav_cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double calculateTotalAmount(List<Product> products) {
    return products.fold(0, (total, product) {
      double discountedPrice = calculateDiscountedPrice(
        product.price,
        product.discountPercentage,
      );
      int quantity = PrefUtils.getProductQuantity(product.id);
      return total + (discountedPrice * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFE6EB),
      ),
      backgroundColor: Color(0xFFFFE6EB),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductsLoaded) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Color(0xFFFFE6EB),
                    child: ListView.builder(
                      itemCount: state.favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final product = state.favoriteProducts[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(color: Colors.white),
                              child: ProductCardWidget(
                                imageUrl: product.thumbnail,
                                productName: product.title,
                                brandName: product.category,
                                originalPrice: product.price,
                                discountedPrice: calculateDiscountedPrice(
                                  product.price,
                                  product.discountPercentage,
                                ),
                                discountPercentage: product.discountPercentage,
                                productId: product.id,
                                onQuantityChanged: (_) {
                                  // Force rebuild to update total amount
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amount Price",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₹${calculateTotalAmount(state.favoriteProducts).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),

                          child: Row(
                            children: [
                              const Text('Check Out'),
                              SizedBox(width: 4),
                              Container(
                                padding: EdgeInsets.all(
                                  6,
                                ), // Padding inside the circle
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Colors
                                          .white, // Background color of the badge
                                ),
                                child: Text(
                                  state.favoriteProducts.length
                                      .toString(), // Number inside the badge
                                  style: TextStyle(
                                    color:
                                        Colors
                                            .pink, // Text color (match the background)
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Text("no items");
        },
      ),
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
