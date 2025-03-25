import 'package:get_it/get_it.dart';
import 'package:havahavai_assignment/features/home/data/data_source/remote_data_source.dart';
import 'package:havahavai_assignment/features/home/data/repository/product_repository_impl.dart';
import 'package:havahavai_assignment/features/home/domain/repository/product_repository.dart';
import 'package:havahavai_assignment/features/home/domain/usecases/get_products.dart';
import 'package:havahavai_assignment/features/home/presentation/bloc/products_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetProducts(repository: sl()));
  sl.registerLazySingleton(() => ProductsBloc(getProducts: sl()));
}
