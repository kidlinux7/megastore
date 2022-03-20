import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megastore/data/models/explore_best_seller_model.dart';
import 'package:megastore/data/repositories/explore_best_seller_repository.dart';
import 'package:megastore/logic/bloc/megastore_bloc.dart';
import 'package:megastore/presentation/widgets/best_seller_grid_Loaded.dart';
import 'package:megastore/presentation/widgets/gridLoading.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late final MegastoreBloc megastoreBloc;
  final ExploreBestSellerRepository exploreBestSellerRepository =
      ExploreBestSellerRepository();
  @override
  void initState() {
    megastoreBloc =
        MegastoreBloc(exploreBestSellerRepository: exploreBestSellerRepository);
    megastoreBloc.add(const FetchBestSellerProducts());
    super.initState();
  }

  @override
  void dispose() {
    megastoreBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: BlocBuilder<MegastoreBloc, MegastoreState>(
            bloc: megastoreBloc,
            builder: (context, state) {
              if (state is ProductsLoading) {
                return GridLoading();
              } else if (state is ProductsLoaded) {
                List<ExploreBestSellerModel> _best_seller_products =
                    state.best_seller;
                return bestsellergridloaded(
                    bestProductsList: _best_seller_products, context: context);
              } else {
                return Text("Else Wait to fetch");
              }
            })

        // BlocListener<MegastoreBloc, MegastoreState>(
        //   bloc: megastoreBloc,
        //   listener: (context, state) {
        //     if (state is ProductsError) {
        //       Scaffold.of(context).showSnackBar(
        //           SnackBar(content: Text('Someting went wrong😝')));
        //     }
        //   },
        //   child: Container(),
        // ),

        );
  }
}
