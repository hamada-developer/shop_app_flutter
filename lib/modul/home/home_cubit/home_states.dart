

import 'package:shop_app/model/update_profile.dart';

abstract class HomeStates {}

class InitialHomeState extends HomeStates {}

class GetDataHomeLoading extends HomeStates {}

class GetDataHomeSuccess extends HomeStates {}

class GetDataHomeError extends HomeStates {}

class GetDataCategoriesLoading extends HomeStates {}

class GetDataCategoriesSuccess extends HomeStates {}

class GetDataCategoriesError extends HomeStates {}

class PostDataFavoriteSuccess extends HomeStates {}

class PostDataFavoriteError extends HomeStates {
  final String? message;

  PostDataFavoriteError({required this.message});
}

class GetDataFavoriteSuccess extends HomeStates {}

class GetDataFavoriteError extends HomeStates {}

class GetDataProfileSuccess extends HomeStates {}

class GetDataProfileError extends HomeStates {}

class PutDataUpdateProfileLoading extends HomeStates {}

class PutDataUpdateProfileSuccess extends HomeStates {
  final UpdateProfile updateProfile;

  PutDataUpdateProfileSuccess(this.updateProfile);
}

class PutDataUpdateProfileError extends HomeStates {}

class PostDataSearchLoading extends HomeStates {}

class PostDataSearchSuccess extends HomeStates {}

class PostDataSearchError extends HomeStates {}

