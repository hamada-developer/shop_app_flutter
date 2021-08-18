import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modul/category/category_screen.dart';
import 'package:shop_app/modul/favorite/favorite_screen.dart';
import 'package:shop_app/modul/home/home_screen.dart';
import 'package:shop_app/modul/settings/settings_screen.dart';

import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {

  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.apps,
      ),
      label: 'Category',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite_outlined,
      ),
      label: 'Favorite',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];
  List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  LayoutCubit() : super(InitialHomeState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  void changeBottomNavigation(int index) {
    this.currentIndex = index;
    emit(ChangeBottomNavigationBar());
  }
}
