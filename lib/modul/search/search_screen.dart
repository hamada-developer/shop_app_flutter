import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/search_model.dart';
import 'package:shop_app/modul/home/home_cubit/home_cubit.dart';
import 'package:shop_app/modul/home/home_cubit/home_states.dart';
import 'package:shop_app/shared/compents/compents.dart';

class SearchScreen extends StatelessWidget {
  final value = TextEditingController();
  List<DataItem> list = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getDataHome()
        ..getDataFavorite()
        ..getDataCategories()
        ..getDataProfile(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          if (state is PostDataSearchSuccess) {
            list = cubit.searchModel!.data!.data;
          }
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  DefaultTextFormField(
                    controller: value,
                    labelText: 'Search',
                    onEditingComplete: () {
                      cubit.searchProducts(value.text.toString());
                    },
                  ),
                  ConditionalBuilder(
                    condition: state is PostDataSearchSuccess,
                    builder: (context) => Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            buildItemSearch(list[index], cubit),
                        itemCount: list.length,
                      ),
                    ),
                    fallback: (context) {
                      return state is! PostDataSearchLoading ?
                      Container():
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildItemSearch(DataItem item, HomeCubit homeCubit) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  item.image.toString(),
                ),
                height: 150.0,
                width: 150.0,
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.6),
                ),
                Row(
                  children: [
                    Text(
                      item.price.toString(),
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        homeCubit.toggleFavoriteFromSearch(item.id);
                      },
                      icon: Icon(
                        homeCubit.favorite[item.id]== true
                            ? Icons.favorite_outlined
                            : Icons.favorite_border_outlined,
                        color: homeCubit.favorite[item.id]== true
                            ? Colors.blue
                            : Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
