import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:havahavai_assignment/features/home/domain/entity/product.dart';

class PrefUtils {
  static final GetStorage _storage = GetStorage();

  static String favList = "Fav_List";
  static String productQuantities = "Product_Quantities";

  // Save quantity for a specific product
  static Future<void> saveProductQuantity(int productId, int quantity) async {
    Map<String, dynamic> quantities = _storage.read(productQuantities) ?? {};
    quantities[productId.toString()] = quantity;
    await _storage.write(productQuantities, quantities);
  }

  // Get quantity for a specific product
  static int getProductQuantity(int productId) {
    Map<String, dynamic> quantities = _storage.read(productQuantities) ?? {};
    return quantities[productId.toString()] ?? 1; // Default to 1 if not found
  }

  // Clear all product quantities
  static Future<void> clearProductQuantities() async {
    await _storage.remove(productQuantities);
  }

  // Save favorite product IDs to storage
  static Future<void> saveFavoriteProducts(List<int> productIds) async {
    await _storage.write(favList, productIds);
  }

  // Read favorite product IDs from storage
  static List<int> getFavoriteProducts() {
    final List<dynamic>? storedIds = _storage.read(favList);
    if (storedIds != null) {
      return List<int>.from(storedIds);
    }
    return [];
  }

  // Clear favorite products from storage
  static Future<void> clearFavoriteProducts() async {
    await _storage.remove(favList);
  }
}
