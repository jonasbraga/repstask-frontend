// import 'dart:ffi';

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
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

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
    await http.delete(uri);
    refreshUserPageStream.sink.add(null);
  }

  Future<List<UserModel>> getUsersList(UserModel user) async {
    // final address = await getIpAddress();

    final response = await http.get(
      Uri.parse('http://$backendAdress/users-by-rep/${user.repId}'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTY4NzM3ODUwMCwiZXhwIjoxNjg3MzgyMTAwfQ.O8wI3iNX7zJsNnwR7HW_pdHaJ0zxK7qZymEqSrB103o', // Replace $token with your actual token
      },
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<UserModel> results = [];
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
              nomeRep: userJson['nomeRep'],
              userPoints: userJson['userPoints'],
              userDoneTasks: userJson['userDoneTasks']);
          results.add(user);
        });
      }
      if (user.imagePath == null) {
        final userPrefer = UserPreferences.myUser;
        user.imagePath = userPrefer.imagePath;
      }
      return results;
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future getUsers(UserModel user) async {
    final address = await getIpAddress();

    final response = await http.get(
      Uri.parse('http://$backendAdress/users/2'),
      headers: {'Origin': address},
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body != null) {
        UserModel user = UserModel(
          id: body['id'],
          name: body['name'],
          email: body['email'],
          imagePath: body['photo'],
          userType: body['user_type'],
          nickname: body['nickname'],
          password: body['password'],
          repId: body['reps_id'],
          nomeRep: body['nomeRep'],
          userPoints: body['userPoints'],
          userDoneTasks: body['userDoneTasks'],
          // isDarkMode: body['isDarkMode'],
        );
        if (user.imagePath == null) {
          final userPrefer = UserPreferences.myUser;
          user.imagePath = userPrefer.imagePath;
        }
        return user;
      } else {
        throw Exception('Failed to load User');
      }
    }
  }

  Future updateUser(UserModel user) async {
    final Uri uri = Uri.parse('http://$backendAdress/users/${user.id}');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var data = {
      'name': user.name,
      // 'email': user.email,
      'nickname': user.nickname,
      'password': user.password,
      'photo': user.imagePath,
      // 'nomeRep': user.nomeRep,
      // 'user_type': user.userType,
      // 'reps_id': user.nomeRep,
      // 'isDarkMode': newUser.isDarkMode,
      // 'id': user.id,
      // 'userPoints': user.userPoints,
    };
    var body = json.encode(data);

    final response = await http.patch(uri, headers: headers, body: body);
    refreshUserPageStream.sink.add(null);
  }
}
