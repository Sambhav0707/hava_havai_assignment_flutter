import 'package:dartz/dartz.dart';
import 'package:havahavai_assignment/core/errors/failures.dart';
import 'package:havahavai_assignment/features/home/domain/entity/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}