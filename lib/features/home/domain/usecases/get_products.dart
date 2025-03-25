import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:havahavai_assignment/core/errors/failures.dart';
import 'package:havahavai_assignment/core/usecase/usecase.dart';
import 'package:havahavai_assignment/features/home/domain/entity/product.dart';
import 'package:havahavai_assignment/features/home/domain/repository/product_repository.dart';

class GetProducts extends UseCase<List<Product>, NoParams> {
 final ProductRepository repository;

  GetProducts({required this.repository});

  @override
  FutureOr<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
   
  }
}