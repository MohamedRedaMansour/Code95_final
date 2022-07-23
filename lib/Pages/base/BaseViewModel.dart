import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



class BaseViewModel extends ChangeNotifier{
  ValueNotifier<bool> get loading => setLoading;
  ValueNotifier<bool> setLoading = ValueNotifier(false);

  ValueNotifier<bool> get successResponse => aSuccessResponse;
  ValueNotifier<bool> aSuccessResponse = ValueNotifier(true);

  ValueNotifier<int> get responseCode => _responseCode;
  ValueNotifier<int> _responseCode = ValueNotifier(200);



  dynamic returnResponse(Response response) {
    _responseCode.value = response.statusCode!;
    switch (response.statusCode) {
      case 200:
        setLoading.value = false;
        aSuccessResponse.value = true;
        var responseJson = json.decode(json.encode(response.data)) as Map<dynamic, dynamic>;
        return responseJson;
      default:
        aSuccessResponse.value = false;
        break;
    }
  }


  String getNumberWithoutFirstZero(String number ){
    if(number.isNotEmpty){
      if(number[0] == '0'){
        return number.substring(1);
      }else{
        return number;
      }
    }else{
      return number;
    }

  }
}
