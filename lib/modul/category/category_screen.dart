import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/modul/home/home_cubit/home_cubit.dart';
import 'package:shop_app/modul/home/home_cubit/home_states.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var categories = HomeCubit.get(context).categoriesModel!.data!.data;
          return ListView.builder(
            itemBuilder: (context, index) => BuildItemCategories(categories: categories[index]),
            itemCount: categories.length,
          );
        }
    );
  }
}

class BuildItemCategories extends StatelessWidget {
  final DataObjList categories;

  const BuildItemCategories({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              categories.image.toString(),
            ),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            categories.name.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.grey[800],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
