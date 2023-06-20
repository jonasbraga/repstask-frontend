import 'dart:ffi';

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
      // 'email': newUser.email,
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
