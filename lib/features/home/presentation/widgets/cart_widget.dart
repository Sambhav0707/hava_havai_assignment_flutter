import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartWidget extends StatelessWidget {
  final String productName;
  final String brand;
  final double originalPrice;
  final double discountedPrice;
  final String imageUrl;
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;
  final double discountPercentage;
  final bool isFavorite;

  const CartWidget({
    super.key,
    required this.productName,
    required this.brand,
    required this.originalPrice,
    required this.discountedPrice,
    required this.imageUrl,
    required this.onAddPressed,
    required this.discountPercentage,
    required this.isFavorite,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    // final discountPercentage = ((originalPrice - discountedPrice) /
    //         originalPrice *
    //         100)
    //     .toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image with Add Button overlay
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(12),
                color: Colors.black12,
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.pink),
                      ),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
              ),
            ),
            Positioned(
              right: 7,
              bottom: 8,
              child: Container(
                height: 20,

                child:
                    isFavorite
                        ? ElevatedButton(
                          onPressed: onRemovePressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'remove',
                            style: TextStyle(color: Colors.red.shade300),
                          ),
                        )
                        : ElevatedButton(
                          onPressed: onAddPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.red.shade300),
                          ),
                        ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 16),

        // Product Details
        Container(
          height: 80,
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 4),
                Text(
                  brand,
                  style: TextStyle(fontSize: 9, color: Colors.grey[800]),
                ),
                // const SizedBox(height: 8),

                // Price Section
                Row(
                  children: [
                    Text(
                      '₹${originalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '₹${discountedPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 8,
                    //     vertical: 4,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.green,
                    //     borderRadius: BorderRadius.circular(6),
                    //   ),
                    //   child:
                    // ),
                  ],
                ),
                Text(
                  '$discountPercentage% OFF',
                  style: TextStyle(
                    color: Colors.pink.shade400,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
