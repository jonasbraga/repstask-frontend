import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:reptask/controllers/streams_controller.dart';

import 'package:reptask/models/reward_model.dart';
import 'package:reptask/utils/user_preferences.dart';

import '../configs/config.dart';

class RewardController {
  Future createNewReward(RewardModel rewardData) async {
    final Uri uri = Uri.parse('http://$backendAdress/items');
    final headers = {
      'Authorization':
          'Bearer ${UserPreferences.myUser.token}', // Replace $token with your actual token
    };
    var data = {'title': rewardData.titulo, 'value': rewardData.pontos};

    var body = json.encode(data);
    await http.post(uri, headers: headers, body: body);
    refreshRewardsPageStream.sink.add(data);
  }

  Future<List<RewardModel>> getRewardsList() async {
    // final address = await getIpAddress();

    final response = await http.get(
      Uri.parse('http://$backendAdress/items-all'),
      headers: {
        'Authorization':
            'Bearer ${UserPreferences.myUser.token}', // Replace $token with your actual token
      },
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<RewardModel> results = [];
      if (body.length > 0) {
        body.forEach((rewardJson) {
          RewardModel reward = RewardModel(
              id: rewardJson['id'],
              pontos: rewardJson['pontos'],
              titulo: rewardJson['titulo']);
          results.add(reward);
        });
      }
      return results;
    } else {
      return [];
    }
  }

  Future deleteReward(int id) async {
    final Uri uri = Uri.parse('http://$backendAdress/items/$id');
    await http.delete(uri);
    refreshRewardsPageStream.sink.add(null);
  }

  Future updateUser(RewardModel reward) async {
    final Uri uri = Uri.parse('http://$backendAdress/items/${reward.id}');
    final token = UserPreferences.myUser.token;
    final headers = {
      'Authorization': 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    var data = {
      'id': reward.id,
      'value': reward.pontos,
      'title': reward.titulo
    };
    var body = json.encode(data);

    await http.patch(uri, headers: headers, body: body);
    refreshRewardsPageStream.sink.add(null);
  }
}
