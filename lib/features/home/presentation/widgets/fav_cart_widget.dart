import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:havahavai_assignment/core/pref%20utils/pref_utils.dart';

class ProductCardWidget extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final String brandName;
  final double originalPrice;
  final double discountedPrice;
  final double discountPercentage;
  final VoidCallback? onAddPressed;
  final VoidCallback? onRemovePressed;
  final int productId;
  final Function(int)? onQuantityChanged;

  const ProductCardWidget({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.brandName,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.productId,
    this.onAddPressed,
    this.onRemovePressed,
    this.onQuantityChanged,
  });

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = PrefUtils.getProductQuantity(widget.productId);
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      PrefUtils.saveProductQuantity(widget.productId, quantity);
      widget.onQuantityChanged?.call(quantity);
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        PrefUtils.saveProductQuantity(widget.productId, quantity);
        widget.onQuantityChanged?.call(quantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              // borderRadius: BorderRadius.circular(8),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              placeholder:
                  (context, url) => Center(
                    child: CircularProgressIndicator(color: Colors.grey[400]),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.productName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.brandName,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                // const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '₹${widget.originalPrice}',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[600],
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '₹${widget.discountedPrice}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                Text(
                  '${widget.discountPercentage}% OFF',
                  style: TextStyle(
                    color: Colors.pink.shade200,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Control
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.black),
                    onPressed: decrementQuantity,
                    iconSize: 20,
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: incrementQuantity,
                    iconSize: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
