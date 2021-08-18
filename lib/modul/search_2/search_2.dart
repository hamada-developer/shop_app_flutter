import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modul/home/home_cubit/home_cubit.dart';
import 'package:shop_app/modul/home/home_cubit/home_states.dart';

class Search2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('this is search')),
          );
        },
      ),
    );
  }
}
