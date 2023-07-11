// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
import 'package:reptask/configs/config.dart';
import 'package:reptask/controllers/streams_controller.dart';
import 'package:reptask/models/user_model.dart';
import 'package:reptask/utils/user_preferences.dart';

class UserController {
  Future createNewUser(UserModel newUser, int repId) async {
    final Uri uri = Uri.parse('http://$backendAdress/users');
    final token = UserPreferences.myUser.token;
    final headers = {
      'Authorization': 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    var data = {
      'name': newUser.name,
      'email': newUser.email,
      'password': newUser.password,
      'nickname': newUser.nickname,
      'photo': newUser.imagePath,
      // 'nome_rep': newUser.nomeRep,
      // 'isDarkMode': newUser.isDarkMode,
      // 'id': newUser.id,
      'user_type': 0,
      'reps_id': newUser.repId
      // 'userPoints': newUser.userPoints,
    };
    var body = json.encode(data);

    final response = await http.post(uri, headers: headers, body: body);
    refreshUserPageStream.sink.add(data);
  }

  Future<String> getIpAddress() async {
    try {
      var interfaces = await NetworkInterface.list(
        includeLinkLocal: true,
        type: InternetAddressType.IPv4,
      );

      for (var interface in interfaces) {
        for (var address in interface.addresses) {
          if (!address.isLoopback) {
            return address.address;
          }
        }
      }
    } on PlatformException catch (e) {
      print('Erro ao obter o endereço IP: ${e.message}');
    }

    return 'Endereço IP não encontrado';
  }

  Future deleteTask(int id) async {
    final Uri uri = Uri.parse('http://$backendAdress/users/$id');
    final token = UserPreferences.myUser.token;
    final headers = {
      'Authorization': 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    await http.delete(uri, headers: headers);
    refreshUserPageStream.sink.add(null);
  }

  Future<List<UserModel>> getUsersList(UserModel user, String token) async {
    // final address = await getIpAddress();

    final response = await http.get(
      Uri.parse('http://$backendAdress/users-by-rep/${user.repId}'),
      headers: {
        'Authorization':
            'Bearer $token', // Replace $token with your actual token
      },
    );
    List<UserModel> results = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body.length > 0) {
        body.forEach((userJson) {
          UserModel user = UserModel(
            id: userJson['id'],
            name: userJson['name'],
            email: userJson['email'],
            imagePath: userJson['photo'],
            userType: userJson['user_type'],
            nickname: userJson['nickname'],
            password: userJson['password'],
            repId: userJson['reps_id'],
            nomeRep: userJson['rep_name'],
            userPoints: userJson['punctuation'].toString(),
            userDoneTasks: userJson['finished_tasks'],
            token: token,
          );
          results.add(user);
        });
      }
      if (user.imagePath == null) {
        final userPrefer = UserPreferences.myUser;
        user.imagePath = userPrefer.imagePath;
      }
      return results;
    } else {
      results.add(UserPreferences.myUser);
      return results;
    }
  }

  Future updateUser(UserModel user) async {
    final Uri uri = Uri.parse('http://$backendAdress/users/${user.id}');
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer ${user.token}',
    };

    var data = {
      'name': user.name,
      'nickname': user.nickname,
      'photo': user.imagePath,
    };
    var body = json.encode(data);

    final response = await http.patch(uri, headers: headers, body: body);
    refreshUserPageStream.sink.add(null);
  }

  Future updatePassword(
      UserModel user, String currentPassword, String newPassword) async {
    final Uri uri =
        Uri.parse('http://$backendAdress/change-password/${user.id}');
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer ${user.token}',
    };
    var data = {
      'oldPassword': currentPassword,
      'newPassword': newPassword,
    };
    var body = json.encode(data);

    final response = await http.post(uri, headers: headers, body: body);
    debugPrint(response.toString());
    refreshUserPageStream.sink.add(null);
    // if (response.statusCode == 200) {
    return response.statusCode;
    // } else {
    //   return false;
    // throw Exception(
    //     'Failed to create login. Status code: ${response.statusCode}');
    // // return (user);
    // }
  }
}
