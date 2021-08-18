import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/get_favorite.dart';
import 'package:shop_app/modul/home/home_cubit/home_cubit.dart';
import 'package:shop_app/modul/home/home_cubit/home_states.dart';
class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.getFavorite != null,
          builder: (context) =>ListView.builder(
            itemBuilder: (
                context,
                index,
                ) =>
                buildItemGridView(cubit.getFavorite!.data!.data[index].product, cubit),
            // itemBuilder: (context, index,) =>buildItemGridView2(),
            itemCount: cubit.getFavorite!.data!.data.length,
            physics: BouncingScrollPhysics(),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildItemGridView(Product? model, HomeCubit cubit) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              width: 150.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      model!.image.toString(),
                    ),
                    height: 150.0,
                    width: 150.0,
                  ),
                  if (model.oldPrice.round() != model.price.round())
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 20.0,
                        bottom: 8.0,
                        end: 20.0
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'discount'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        color: Colors.red.withOpacity(0.9),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.6),
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
                        },
                        icon: Icon(
                          cubit.favorite[model.id] == true
                              ? Icons.favorite_outlined
                              : Icons.favorite_border_outlined,
                          color: cubit.favorite[model.id] == true
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
