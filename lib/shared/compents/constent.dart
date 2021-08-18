import 'package:flutter/material.dart';
import 'package:shop_app/modul/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import 'compents.dart';


const String BASE_URL = 'https://student.valuxapps.com/api/';

void logout(BuildContext context) {
  CashHelper.removeFromSharedPreferences(key: 'token');
  navigateToAndFinish(context: context, widget: LoginScreen());
}

/*
 * Headers
 */
///[LANG] = [AR] OR [EN]
const String LANG = 'lang';
const String AR = 'ar';
const String EN = 'en';

///[CONTENT_TYPE] = [APPLICATION_JSON]
const String CONTENT_TYPE = 'Content-Type';
const String APPLICATION_JSON = 'application/json';

///[AUTHORIZATION] = [token]
const String AUTHORIZATION = 'Authorization';
String token = '';

// favorite
const String PRODUCT_ID = 'product_id' ;
