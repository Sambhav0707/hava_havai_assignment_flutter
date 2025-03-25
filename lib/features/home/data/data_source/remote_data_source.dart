import 'package:havahavai_assignment/core/constants/string_contants.dart';
import 'package:havahavai_assignment/features/home/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract interface class RemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(ApiStrings.apiEndPoint));

      if (response.statusCode == 200) {
        // Convert the response body into a Map
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Extract the 'products' list from the JSON map
        final List<dynamic> productsList = jsonData['products'];

        // Map the list to ProductModel
        return productsList.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // Handle the error appropriately
      throw Exception('Error fetching products: $e');
    }
  }
}
