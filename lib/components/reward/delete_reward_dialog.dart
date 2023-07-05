import 'package:flutter/material.dart';
import 'package:reptask/models/reward_model.dart';

import '../../controllers/reward_controller.dart';

class DeleteRewardDialog extends StatefulWidget {
  const DeleteRewardDialog({super.key, required this.rewardData});
  final RewardModel rewardData;

  @override
  State<DeleteRewardDialog> createState() => _DeleteRewardDialogState();
}

class _DeleteRewardDialogState extends State<DeleteRewardDialog> {
  RewardController rewardController = RewardController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.rewardData.titulo),
      content: Text(
          'Você deseja deletar recompensa "${widget.rewardData.titulo}" ?'),
      actions: [
        TextButton(
            child: const Text(
              "NÃO",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        TextButton(
          child: const Text(
            "SIM",
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            Navigator.pop(context);
            rewardController.deleteReward(widget.rewardData.id ?? 0);
          },
        )
      ],
    );
  }
}
