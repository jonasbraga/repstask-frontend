import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reptask/components/reward/buy_reward_dialog.dart';
import 'package:reptask/components/reward/delete_reward_dialog.dart';
import 'package:reptask/controllers/reward_controller.dart';

import '../../controllers/streams_controller.dart';
import '../../models/reward_model.dart';
import '../../utils/user_preferences.dart';
import '../bottom_modal.dart';
import 'create_reward_modal.dart';

class RewardsList extends StatefulWidget {
  const RewardsList({super.key});

  @override
  State<RewardsList> createState() => _RewardsListState();
}

class _RewardsListState extends State<RewardsList> {
  RewardController rewardController = RewardController();
  List<RewardModel> rewardList = [];
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = refreshRewardsPageStream.stream.listen((event) {
      refreshPage();
    });
    rewardController
        .getRewardsList()
        .then((rewardResults) => setState(() => rewardList = rewardResults));
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: rewardList.length,
        itemBuilder: (context, index) {
          return Card(
            key: ValueKey(index),
            child: ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BuyRewardDialog(rewardData: rewardList[index]);
                    });
              },
              title: Text(rewardList[index].titulo),
              subtitle: Text('${rewardList[index].pontos}pts'),
              trailing: Wrap(
                spacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  if (UserPreferences.myUser.userType == 1)
                    StatefulBuilder(builder: (context, setState) {
                      return PopupMenuButton<String>(
                          onSelected: (value) {
                            switch (value) {
                              case "option1":
                                showModal(
                                    context,
                                    CreateRewardModal(
                                        rewardDataSended: rewardList[index]));
                                break;
                              case "option2":
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DeleteRewardDialog(
                                        rewardData: rewardList[index],
                                      );
                                    });
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                                const PopupMenuItem<String>(
                                    value: 'option1',
                                    child: ListTile(
                                      title: Text('Editar'),
                                      trailing: Icon(Icons.create_rounded),
                                    )),
                                const PopupMenuItem<String>(
                                    value: 'option2',
                                    child: ListTile(
                                      title: Text('Excluir'),
                                      trailing: Icon(Icons.delete),
                                    ))
                              ]);
                    })
                  else
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BuyRewardDialog(
                                  rewardData: rewardList[index]);
                            });
                      },
                    )
                ],
              ),
            ),
          );
        });
  }

  Future<void> refreshPage() async {
    rewardController
        .getRewardsList()
        .then((rewardResults) => setState(() => rewardList = rewardResults));
  }
}
