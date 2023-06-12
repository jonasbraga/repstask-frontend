import 'package:flutter/material.dart';
import 'package:reptask/components/reward/create_reward_modal.dart';
import 'package:reptask/components/reward/rewards_list.dart';

import '../components/bottom_modal.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja de Pontos'),
      ),
      body: Column(
        children: const [Expanded(child: RewardsList(isAdmUser: true))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(context, const CreateRewardModal());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
