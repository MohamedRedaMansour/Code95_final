/// people : [{"ser_id":"12","first_name":"ali","last_name":"hima","full_name":"ali hima","gender":"male","age":"15"},{"ser_id":"11","first_name":"mohamed","last_name":"mansour","full_name":"mohamed mansour","gender":"male","age":"21"},{"ser_id":"10","first_name":"kamel","last_name":"ali","full_name":"kamel ali","gender":"male","age":"30"},{"ser_id":"9","first_name":"nora","last_name":"ali","full_name":"nora ali","gender":"Female","age":"45"},{"ser_id":"8","first_name":"asmaa","last_name":"kamel","full_name":"asmaa kamel","gender":"female","age":"27"},{"ser_id":"7","first_name":"khaled","last_name":"ahmed","full_name":"khaled ahmed","gender":"male","age":"52"},{"ser_id":"15","first_name":"emad","last_name":"mohamed","full_name":"emad mohamed","gender":"male","age":"69"},{"ser_id":"16","first_name":"aliaa","last_name":"reda","full_name":"aliaa reda","gender":"female","age":"19"},{"ser_id":"16","first_name":"zeinab","last_name":"dewedar","full_name":"zeinab dewedar","gender":"female","age":"25"},{"ser_id":"20","first_name":"ragab","last_name":"mansour","full_name":"ragab masnour","gender":"male","age":"36"}]

class FilterResponse {
  FilterResponse({
      this.people,});

  FilterResponse.fromJson(dynamic json) {
    if (json['people'] != null) {
      people = [];
      json['people'].forEach((v) {
        people?.add(People.fromJson(v));
      });
    }
  }
  List<People>? people;
FilterResponse copyWith({  List<People>? people,
}) => FilterResponse(  people: people ?? this.people,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (people != null) {
      map['people'] = people?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ser_id : "12"
/// first_name : "ali"
/// last_name : "hima"
/// full_name : "ali hima"
/// gender : "male"
/// age : "15"

class People {
  People({
      this.serId, 
      this.firstName, 
      this.lastName, 
      this.fullName, 
      this.gender, 
      this.age,});

  People.fromJson(dynamic json) {
    serId = json['ser_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    gender = json['gender'];
    age = json['age'];
  }
  String? serId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? gender;
  String? age;
People copyWith({  String? serId,
  String? firstName,
  String? lastName,
  String? fullName,
  String? gender,
  String? age,
}) => People(  serId: serId ?? this.serId,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  fullName: fullName ?? this.fullName,
  gender: gender ?? this.gender,
  age: age ?? this.age,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ser_id'] = serId;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['full_name'] = fullName;
    map['gender'] = gender;
    map['age'] = age;
    return map;
  }

}