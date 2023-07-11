import 'package:flutter/material.dart';
import 'package:reptask/controllers/reward_controller.dart';
import 'package:reptask/models/reward_model.dart';

class BuyRewardDialog extends StatefulWidget {
  const BuyRewardDialog({super.key, required this.rewardData});
  final RewardModel rewardData;

  @override
  State<BuyRewardDialog> createState() => _BuyRewardDialogState();
}

class _BuyRewardDialogState extends State<BuyRewardDialog> {
  RewardController rewardController = RewardController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.rewardData.titulo),
      content: Text(
          "Você deseja adquirir ${widget.rewardData.titulo} por ${widget.rewardData.pontos}pts ?"),
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
            rewardController.buyReward(widget.rewardData);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
