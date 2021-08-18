import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/model/home_model.dart';

import 'home_cubit/home_cubit.dart';
import 'home_cubit/home_states.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is PostDataFavoriteError){
          Fluttertoast.showToast(
              msg: state.message.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => buildBanners(
            cubit.homeModel!,
            cubit.categoriesModel!,
            cubit,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget buildBanners(
  HomeModel model,
  CategoriesModel categoriesModel,
  HomeCubit cubit,
) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image.toString()),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              autoPlay: true,
              initialPage: 0,
              reverse: false,
              viewportFraction: 1,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayInterval: Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: Duration(
                seconds: 1,
              ),
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 110,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategories(categoriesModel.data!.data[index]),
                    itemCount: categoriesModel.data!.data.length,
                    physics: BouncingScrollPhysics(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.grey[800],
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: 10,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.75,
                  children: List.generate(
                    model.data!.products.length,
                    (index) => buildItemGridView(model.data!.products[index] , cubit),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildItemGridView(ProductsObj model , HomeCubit cubit) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                model.image.toString(),
              ),
              height: 200.0,
            ),
            if (model.oldPrice.round() != model.price.round())
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 1,
                ),
                child: Text(
                  'discount'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                color: Colors.red,
              ),
          ],
        ),
        Container(
          height: 50,
          child: Text(
            model.name.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(height: 1.6),
          ),
        ),
        Row(
          children: [
            Text(
              model.price.round().toString(),
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            if (model.oldPrice.round() != model.price.round())
              Text(
                model.oldPrice.round().toString(),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            Spacer(),
            IconButton(
              onPressed: () {
                cubit.toggleFavorite(model.id);
                print('hamada ${model.id} ');
              },
              icon: Icon(
                cubit.favorite[model.id]== true? Icons.favorite_outlined
                : Icons.favorite_border_outlined,
                color:cubit.favorite[model.id]== true?  Colors.blue : Colors.grey[900],
              ),
            ),
          ],
        ),
      ],
    );

Widget buildCategories(DataObjList dataObjList) => Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: 110,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(
                    dataObjList.image.toString(),
                  ),
                  fit: BoxFit.cover,
                  height: 110,
                  width: 150,
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  color: Colors.black.withOpacity(.7),
                  width: 150.0,
                  child: Text(
                    dataObjList.name.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
