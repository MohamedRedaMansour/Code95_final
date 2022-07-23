import 'package:code95_final/Pages/base/BaseViewModel.dart';
import 'package:code95_final/Pages/filterPage/view/ResultScreen.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../data/remote/ApiCall.dart';
import '../../../data/remote/GetResponse.dart';
import '../../../data/remote/RemoteConstant.dart';
import '../../../utils/helpers/extension.dart';
import '../model/FilterResponse.dart';

class FilterViewModel extends BaseViewModel with GetResponse{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showMore = false;
  FilterResponse? filterResponse;
  List<People> usersList = [];
  List<String> list = ['First Name', 'Last Name', 'Full Name','Age'];
  String dropdownValue = 'First Name';

  List<String> equalList = ['=', '!=','>','<'];
  String dropdownEqualNAme = '=';

  List<String> andOrList = ['AND', 'OR'];
  String dropdownAndOr = 'AND';

  List<String> genderList = ['Male', 'Female'];
  String dropdownGender = 'Male';

  List<String> equalListGender = ['=', '!='];
  String dropdownEqualGender = '=';

  bool firstTextFieldValidated = false;
  bool secondTextFieldValidated = false;

  String firstValue = '';
  String secondValue = '';
  BuildContext? context;


  validateData(){
    formKey.currentState!.save();
    if(formKey.currentState!.validate()){
      getAllData();
    }else{
      toastApp("choose desired attributes");
    }
  }

  List<String> equalListAge(){
    if(dropdownValue != 'Age' ){
      return [equalList[0],equalList[1]];
    }else{
      return equalList ;
    }
  }


  getAllData() async {
    ApiCall.makeCall(Constant.METHOD_GET,
        "v1/4eb69fb8-19d9-425e-ba05-784970fa2862", {}, this);
  }


  @override
  void getResponse(Response response) {
    var rowResponse = returnResponse(response);
    try {
      filterResponse = FilterResponse.fromJson(rowResponse);
      Navigator.push(context!,
          MaterialPageRoute(builder: (context) => ResultScreen(viewModel: this,)));
      usersList = filterResponse?.people ?? [];
      if(dropdownValue == 'Age'){
        filterWithAge();
      }else{
        filterWithoutAge();
      }
      if (showMore == true) {
        if(dropdownAndOr == andOrList[0]) {
          if (dropdownEqualGender == '=') {
            filterResponse?.people = filterResponse?.people
                ?.where((x) =>
            x.gender!
                .toLowerCase()
                == (dropdownGender.toLowerCase()))
                .toList();
          } else {
            filterResponse?.people = filterResponse?.people
                ?.where((x) =>
            !(x.gender!
                .toLowerCase() ==
                (dropdownGender.toLowerCase())))
                .toList();
          }
        }else{
          if (dropdownEqualGender == '=') {
            usersList = usersList
                .where((x) =>
            x.gender!
                .toLowerCase()
                == (dropdownGender.toLowerCase()))
                .toList();
            filterResponse?.people?.addAll(usersList);
          } else {
            usersList = usersList.where((x) =>
            !(x.gender!
                .toLowerCase()
                ==
                (dropdownGender.toLowerCase())))
                .toList();
            filterResponse?.people?.addAll(usersList);
          }
        }
      }else{
        usersList = filterResponse?.people ?? [];
      }
      usersList = filterResponse?.people ?? [];
      notifyListeners();
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
  }


  filterWithoutAge(){
    if (dropdownEqualNAme == '=') {
      if (dropdownValue == list[0]) {
        filterResponse?.people = filterResponse?.people
            ?.where((x) => x.firstName!
            .toLowerCase()
            .contains(firstValue.toLowerCase()))
            .toList();
      } else if(dropdownValue == list[1]) {
        filterResponse?.people = filterResponse?.people
            ?.where((x) => x.lastName!
            .toLowerCase()
            .contains(firstValue.toLowerCase()))
            .toList();
      }else if(dropdownValue == list[2]){
        filterResponse?.people = filterResponse?.people
            ?.where((x) => x.fullName!
            .toLowerCase()
            .contains(firstValue.toLowerCase()))
            .toList();
      }else{
        filterResponse?.people = filterResponse?.people
            ?.where((x) => x.age!
            .toLowerCase()
            .contains(firstValue.toLowerCase()))
            .toList();
      }
    } else {
      if (dropdownValue == list[0]) {
        filterResponse?.people = filterResponse?.people
            ?.where((x) => !(x.firstName!
            .toLowerCase()
            .contains(firstValue.toLowerCase())))
            .toList();
      } else {
        filterResponse?.people= filterResponse?.people
            ?.where((x) => !(x.lastName!
            .toLowerCase()
            .contains(firstValue.toLowerCase())))
            .toList();
      }
    }
  }

  filterWithAge(){
    if(dropdownEqualNAme == equalList[0]){
      filterResponse?.people = filterResponse?.people
          ?.where((x) => x.age!
          == (firstValue))
          .toList();
    }else if(dropdownEqualNAme == equalList[1]){
      filterResponse?.people = filterResponse?.people
          ?.where((x) => x.age!
          != (firstValue))
          .toList();
    }else if(dropdownEqualNAme == equalList[2]){
      filterResponse?.people = filterResponse?.people
          ?.where((x) => int.parse(x.age!)
          > (int.parse(firstValue)))
          .toList();
    }else{
      filterResponse?.people = filterResponse?.people
          ?.where((x) => int.parse(x.age!)
          < (int.parse(firstValue)))
          .toList();
    }
  }
}