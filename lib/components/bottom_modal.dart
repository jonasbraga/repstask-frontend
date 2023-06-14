import 'package:flutter/material.dart';

showModal(context, modalContent, {bool backgroungTransparent = true}) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: backgroungTransparent
          ? Colors.transparent
          : const Color.fromRGBO(0, 0, 0, 0.4),
      builder: (context) {
        return SingleChildScrollView(
          child: Wrap(children: [
            Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                child: Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  child: modalContent,
                ))
          ]),
        );
      });
}