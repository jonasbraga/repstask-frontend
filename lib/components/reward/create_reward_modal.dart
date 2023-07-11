import 'package:flutter/material.dart';
import 'package:reptask/models/reward_model.dart';

import '../../controllers/reward_controller.dart';

class CreateRewardModal extends StatefulWidget {
  const CreateRewardModal({super.key, this.rewardDataSended});
  final RewardModel? rewardDataSended;

  @override
  State<CreateRewardModal> createState() => _CreateRewardModalState();
}

class _CreateRewardModalState extends State<CreateRewardModal> {
  late RewardModel rewardData;
  TextEditingController rewardNameController = TextEditingController();
  TextEditingController rewardPointsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    rewardData = widget.rewardDataSended ?? RewardModel(pontos: 0, titulo: '');

    rewardNameController.text = rewardData.titulo;
    rewardPointsController.text = rewardData.pontos.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Nova Recompensa',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    fontSize: 24,
                    letterSpacing: 0.15)),
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Color.fromRGBO(0, 0, 0, 0.87),
                ))
          ],
        ),
        Container(
          height: 55,
          margin: const EdgeInsets.only(top: 12),
          child: TextFormField(
            controller: rewardNameController,
            decoration: const InputDecoration(
                labelText: 'Título',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Container(
          height: 55,
          margin: const EdgeInsets.only(top: 12),
          child: TextFormField(
            controller: rewardPointsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: 'Pontos',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 20,
          margin: const EdgeInsets.only(top: 32, bottom: 36),
          child: TextButton(
              onPressed: () {
                widget.rewardDataSended != null
                    ? updateReward()
                    : criarReward();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: widget.rewardDataSended != null
                  ? const Text(
                      'ATUALIZAR',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.25,
                          fontSize: 16),
                    )
                  : const Text(
                      'CRIAR',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.25,
                          fontSize: 16),
                    )),
        )
      ],
    );
  }

  criarReward() {
    RewardController().createNewReward(RewardModel(
        pontos: int.tryParse(rewardPointsController.text) ?? 0,
        titulo: rewardNameController.text));
  }

  updateReward() {
    RewardController().updateReward(RewardModel(
        id: rewardData.id,
        pontos: int.tryParse(rewardPointsController.text) ?? 0,
        titulo: rewardNameController.text));
  }
}
