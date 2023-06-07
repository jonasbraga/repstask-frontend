import 'package:flutter/material.dart';

class CreateRewardModal extends StatefulWidget {
  const CreateRewardModal({super.key});

  @override
  State<CreateRewardModal> createState() => _CreateRewardModalState();
}

class _CreateRewardModalState extends State<CreateRewardModal> {
  TextEditingController rewardNameController = TextEditingController();
  TextEditingController rewardPointsController = TextEditingController();

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
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'CRIAR',
                style: TextStyle(
                    color: Colors.white, letterSpacing: 1.25, fontSize: 16),
              )),
        )
      ],
    );
  }
}
