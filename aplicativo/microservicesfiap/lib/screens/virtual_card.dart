import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:microservicesfiap/model/credit_card.dart';
import 'package:microservicesfiap/utilities/constants.dart';
import 'package:microservicesfiap/utilities/util.dart';

class VirtualCard extends StatelessWidget {
  VirtualCard({required this.card});

  var format = DateFormat.yMd('pt_BR');

  final CreditCard card;

  var random = Random();
  //int randomCVV = random.nextInt(999);

  static Widget sizedBox = const SizedBox(width: 5.0);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 16,
      ),
      elevation: 0.0,
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              sizedBox,
              const Icon(
                Icons.credit_card_outlined,
                color: Colors.white,
                size: 25.0,
              ),
              sizedBox,
              const Text(
                "Cartão Virtual",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              sizedBox,
              Text(
                'Número do Cartão: ${card.numeroCartao}',
                style: kWidgetText,
              ),
            ],
          ),
          Row(
            children: [
              sizedBox,
              Text(
                'Saldo: ${Util.currencyFormatter.format(card.saldo)}',
                style: kWidgetText,
              ),
              sizedBox,
              Text(
                'CVV: ${random.nextInt(999)}',
                style: kWidgetText,
              )
            ],
          ),
          Row(
            children: [
              sizedBox,
              Text(
                'Expira em: ${format.format(card.prazo)}',
                style: kWidgetText,
              ),
            ],
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}

/*Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15.0),
      ),*/

/*MaterialButton(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 16,
          ),
          elevation: 0.0,
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),*/
