import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:microservicesfiap/model/credit_card.dart';
import 'package:microservicesfiap/model/payment.dart';
import 'package:microservicesfiap/screens/card_details.dart';
import 'package:microservicesfiap/services/cartao_service.dart';
import 'package:microservicesfiap/utilities/constants.dart';
import 'package:microservicesfiap/utilities/util.dart';

class CardWidgetHome extends StatefulWidget {
  @override
  _CardWidgetHomeState createState() => _CardWidgetHomeState();
}

class _CardWidgetHomeState extends State<CardWidgetHome> {
  var format = DateFormat.yMd('pt_BR');

  CreditCard card = CreditCard.emptyCard();

  TextSpan setTextCard() {
    if (card.numeroCartao != '') {
      return TextSpan(
        text: Util.currencyFormatter.format(card.saldo),
        style: kWidgetSpotlightText,
      );
    } else {
      return const TextSpan(
        text: 'Cartão Virtual Inativo',
        style: kWidgetSpotlightText,
      );
    }
  }

  @override
  void initState() {
    getActiveCard().whenComplete(() {
      setState(() {});
    });
  }

  void refreshData() {
    getActiveCard();
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  getActiveCard() async {
    dynamic cartaoAtivo = await CartaoService().getCartaoAtivo();

    setState(() {
      print(cartaoAtivo != null);

      if (cartaoAtivo != null) {
        card = CreditCard.fromJson(cartaoAtivo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        //Navigator.pushNamed(context, '/');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CardDetails(card: card);
            },
          ),
        );
      },
      padding: EdgeInsets.zero,
      shape: const Border(
        top: BorderSide(
          color: Colors.white12,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.credit_card_outlined,
                  color: Colors.white,
                  size: 30.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  'Cartão Virtual',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Expira em: ${format.format(card.prazo)}',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      setTextCard(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: const [
                Text(
                  'Visualizar cartão',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Icon(
                  Icons.navigate_next_outlined,
                  color: Colors.white54,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
