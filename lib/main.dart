import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megastore/data/repositories/explore_best_seller_repository.dart';
import 'package:megastore/logic/bloc/cart_bloc.dart';
import 'package:megastore/logic/bloc/megastore_bloc.dart';
import 'package:megastore/presentation/screens/explore.dart';
import 'package:megastore/presentation/widgets/navbar.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    // print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Color.fromARGB(255, 170, 170, 170), // status bar color
  // ));3

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ExploreBestSellerRepository exploreBestSellerRepository =
      ExploreBestSellerRepository();
  @override
  Widget build(BuildContext context) {
    //Provider must be above route and material
    return MultiBlocProvider(
      providers: [
        BlocProvider<MegastoreBloc>(
            lazy: false,
            create: (BuildContext context) => MegastoreBloc(
                exploreBestSellerRepository: exploreBestSellerRepository)),
        BlocProvider<CartBloc>(
          lazy: false,
          create: (BuildContext context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Navbar(),
      ),
    );
  }
}
