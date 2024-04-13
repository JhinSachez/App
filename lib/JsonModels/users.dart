
// To parse this JSON data, do
//
//     final users = usersFromMap(jsonString);

import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? usrId;
  final String? email;
  final String usrName;
  final String usrPassword;

  Users({
    this.usrId,
    this.email,
    required this.usrName,
    required this.usrPassword,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    usrId: json["usrId"],
    email: json["email"],
    usrName: json["usrName"],
    usrPassword: json["usrPassword"],
  );

  Map<String, dynamic> toMap() => {
    "usrId": usrId,
    "email": email,
    "usrName": usrName,
    "usrPassword": usrPassword,
  };
}
