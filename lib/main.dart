import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'package:havahavai_assignment/core/bloc_observer.dart';

import 'package:havahavai_assignment/core/injection_class.dart' as di;

import 'package:havahavai_assignment/features/home/presentation/bloc/products_bloc.dart';
import 'package:havahavai_assignment/features/home/presentation/screens/home_screen.dart';

void main() async {
  await GetStorage.init();
  // Set up BlocObserver
  Bloc.observer = AppBlocObserver();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(getProducts: di.sl()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
