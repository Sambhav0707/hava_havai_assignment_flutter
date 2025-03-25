import 'package:dartz/dartz.dart';
import 'package:havahavai_assignment/core/errors/failures.dart';
import 'package:havahavai_assignment/features/home/data/data_source/remote_data_source.dart';
import 'package:havahavai_assignment/features/home/domain/entity/product.dart';
import 'package:havahavai_assignment/features/home/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final response = await remoteDataSource.getProducts();
      return Right(response);
    } on GeneralFailure catch (e) {
      return Left(GeneralFailure(e.message));
    }
  }
}
