import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modul/home/home_cubit/home_cubit.dart';
import 'package:shop_app/modul/search/search_screen.dart';
import 'package:shop_app/shared/compents/compents.dart';

import 'layout_cubit/layout_cubit.dart';
import 'layout_cubit/layout_states.dart';


class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()),
        BlocProvider(
          create: (context) => HomeCubit()..getDataHome()..getDataFavorite()
            ..getDataCategories()..getDataProfile(),
        ),
      ],
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                'Salla',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context: context, widget: SearchScreen());
                  },
                  icon: Icon(Icons.search_outlined),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              onTap: (index) => cubit.changeBottomNavigation(index),
              currentIndex: cubit.currentIndex,
            ),
          );
        },
      ),
    );
  }
}
