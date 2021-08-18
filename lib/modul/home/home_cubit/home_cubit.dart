import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/model/favorite_model.dart';
import 'package:shop_app/model/get_favorite.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/model/profile_model.dart';
import 'package:shop_app/model/register_model.dart';
import 'package:shop_app/model/search_model.dart';
import 'package:shop_app/model/update_profile.dart';
import 'package:shop_app/shared/compents/constent.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;

  // get favorite from api HomeModel and SearchModel
  Map<int?, bool?> favorite = {};

  // post Favorite
  FavoriteModel? favoriteModel;

  // get All favorite from api GetFavorite
  GetFavorite? getFavorite;

  ProfileModel? getProfile;

  RegisterModel? registerModel;

  UpdateProfile? updateProfile;

  SearchModel? searchModel;
  bool isSearching = false;

  void getDataHome() {
    if (homeModel == null) {
      emit(GetDataHomeLoading());
      DioHelper.get(
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        path: HOME,
      ).then((value) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data!.products.forEach((element) {
          favorite.addAll({element.id: element.inFavorite});
        });
        emit(GetDataHomeSuccess());
      }).catchError((onError) {
        print('Error : ${onError.toString()}');
        emit(GetDataHomeError());
      });
    } else {
      print('homeModel != null');
      emit(GetDataHomeSuccess());
    }
  }

  void getDataCategories() {
    if (categoriesModel == null) {
      DioHelper.get(
        path: CATEGORIES,
        headers: {
          LANG: EN,
        },
      ).then((value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(GetDataHomeSuccess());
      }).catchError((onError) {
        print('Error Categories : ${onError.toString()}');
      });
    } else {
      emit(GetDataHomeSuccess());
    }
  }

  void toggleFavorite(int? productId) {
    favorite[productId] = toggleBoolean(favorite[productId]);
    emit(PostDataFavoriteSuccess());
    DioHelper.post(
      method: FAVORITE,
      data: {
        PRODUCT_ID: productId,
      },
      headers: {
        CONTENT_TYPE: APPLICATION_JSON,
        AUTHORIZATION: token,
        LANG: EN,
      },
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      if (favoriteModel!.status != true) {
        favorite[productId] = toggleBoolean(favorite[productId]);
        emit(PostDataFavoriteError(message: favoriteModel!.message));
      } else {
        getDataFavorite();
      }
      emit(PostDataFavoriteSuccess());
      if(isSearching == true){
        emit(PostDataSearchSuccess());
      }
    }).catchError((onError) {
      favorite[productId] = toggleBoolean(favorite[productId]);
      emit(PostDataFavoriteError(message: favoriteModel!.message));
    });
  }

  bool? toggleBoolean(bool? fav) {
    return !fav!;
  }

  void getDataFavorite() {
    DioHelper.get(
      path: FAVORITE,
      headers: {
        CONTENT_TYPE: APPLICATION_JSON,
        LANG: EN,
        AUTHORIZATION: token,
      },
    ).then((value) {
      getFavorite = GetFavorite.fromJson(value.data);
      emit(GetDataFavoriteSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetDataFavoriteError());
    });
  }

  void getDataProfile() {
    print(token.toString());
    DioHelper.get(
      path: PROFILE,
      headers: {
        CONTENT_TYPE: APPLICATION_JSON,
        LANG: AR,
        AUTHORIZATION: token,
      },
    ).then((value) {
      getProfile = ProfileModel.fromJson(value.data);
      print(getProfile!.data!.phone);
      emit(GetDataProfileSuccess());
    }).catchError((onError) {
      print("Error: ${onError.toString()}");
      emit(GetDataProfileError());
    });
  }

  void putDataUpdate({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(PutDataUpdateProfileLoading());
    DioHelper.put(
      path: UPDATE_PROFILE,
      headers: {
        CONTENT_TYPE: APPLICATION_JSON,
        AUTHORIZATION: token,
        LANG: EN,
      },
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      updateProfile = UpdateProfile.formJson(value.data);
      print(updateProfile!.data!.phone.toString());
      emit(PutDataUpdateProfileSuccess(updateProfile!));
    }).catchError((onError) {
      print('Error: ${onError.toString()}');
      emit(PutDataUpdateProfileError());
    });
  }

  void searchProducts(String search) {
    emit(PostDataSearchLoading());
    DioHelper.post(
      method: PRODUCTS_SEARCH,
      headers: {
        LANG: EN,
        CONTENT_TYPE: APPLICATION_JSON,
        AUTHORIZATION: token,
      },
      data: {
        'text': search,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      favorite = {};
      searchModel!.data!.data.forEach((element) {
        favorite.addAll({element.id: element.inFavorite});
      });
      emit(PostDataSearchSuccess());
    }).catchError((onError){
      print('Error ${onError.toString()}');
      emit(PostDataSearchError());
    });
  }

  void toggleFavoriteFromSearch(productId){
    favorite[productId] = toggleBoolean(favorite[productId]);
    emit(PostDataSearchSuccess());
    DioHelper.post(
      method: FAVORITE,
      data: {
        PRODUCT_ID: productId,
      },
      headers: {
        CONTENT_TYPE: APPLICATION_JSON,
        AUTHORIZATION: token,
        LANG: EN,
      },
    ).then((value) {
    }).catchError((onError){
      print('Error ${onError.toString()}');
    });
  }
}
