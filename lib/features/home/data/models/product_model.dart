import 'package:havahavai_assignment/features/home/domain/entity/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    super.tags,
    super.brand,
    required super.sku,
    required super.weight,
    super.dimensions,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    super.reviews,
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    super.meta,
    required super.images,
    required super.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as int? ?? 0,
    title: json['title'] as String? ?? '',
    description: json['description'] as String? ?? '',
    category: json['category'] as String? ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
    rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    stock: json['stock'] as int? ?? 0,
    tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    brand: json['brand'] as String?,
    sku: json['sku'] as String? ?? '',
    weight: json['weight'] as int? ?? 0,
    dimensions:
        json['dimensions'] != null
            ? Dimensions.fromJson(json['dimensions'])
            : null,
    warrantyInformation: json['warrantyInformation'] as String? ?? '',
    shippingInformation: json['shippingInformation'] as String? ?? '',
    availabilityStatus: json['availabilityStatus'] as String? ?? '',
    reviews:
        json['reviews'] != null
            ? (json['reviews'] as List).map((e) => Review.fromJson(e)).toList()
            : null,
    returnPolicy: json['returnPolicy'] as String? ?? '',
    minimumOrderQuantity: json['minimumOrderQuantity'] as int? ?? 0,
    meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    images: List<String>.from(json['images'] ?? []),
    thumbnail: json['thumbnail'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'price': price,
    'discountPercentage': discountPercentage,
    'rating': rating,
    'stock': stock,
    'tags': tags,
    'brand': brand,
    'sku': sku,
    'weight': weight,
    'dimensions': dimensions?.toJson(),
    'warrantyInformation': warrantyInformation,
    'shippingInformation': shippingInformation,
    'availabilityStatus': availabilityStatus,
    'reviews': reviews?.map((e) => e.toJson()).toList(),
    'returnPolicy': returnPolicy,
    'minimumOrderQuantity': minimumOrderQuantity,
    'meta': meta?.toJson(),
    'images': images,
    'thumbnail': thumbnail,
  };
}
