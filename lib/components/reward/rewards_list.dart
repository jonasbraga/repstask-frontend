import 'package:flutter/material.dart';

import '../../models/reward_model.dart';

class RewardsList extends StatefulWidget {
  const RewardsList({super.key, required this.isAdmUser});
  final bool isAdmUser;

  @override
  State<RewardsList> createState() => _RewardsListState();
}

class _RewardsListState extends State<RewardsList> {
  List<RewardModel> rewardList = [
    RewardModel(pontos: 500, titulo: 'Dar uma pinga'),
    RewardModel(pontos: 5000, titulo: 'Pizza por conta da casa')
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: rewardList.length,
        itemBuilder: (context, index) {
          return Card(
            key: ValueKey(index),
            child: ListTile(
              onTap: () {
                print("Clicou no cartão");
              },
              title: Text(rewardList[index].titulo),
              subtitle: Text('${rewardList[index].pontos}pts'),
              trailing: Wrap(
                spacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  if (widget.isAdmUser)
                    StatefulBuilder(builder: (context, setState) {
                      return PopupMenuButton<String>(
                          onSelected: (value) {
                            switch (value) {
                              case "option1":
                                print("Abrir modo de edição");
                                break;
                              case "option2":
                                print("Chamar delete reward");
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
                        print('Usuário clicou no presente');
                      },
                    )
                ],
              ),
            ),
          );
        });
  }
}
