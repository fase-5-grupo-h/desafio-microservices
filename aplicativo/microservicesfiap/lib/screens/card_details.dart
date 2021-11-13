import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:microservicesfiap/model/credit_card.dart';
import 'package:microservicesfiap/screens/virtual_card.dart';
import 'package:microservicesfiap/utilities/util.dart';

import 'generate_virtual_card.dart';
import 'generic_widgets/generic_app_bar.dart';

class CardDetails extends StatefulWidget {
  CardDetails({required this.card});

  final CreditCard card;

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  late CreditCard card;

  late Widget widgetCard;

  @override
  void initState() {
    card = widget.card;

    if (card.numeroCartao.isEmpty || card.numeroCartao == null) {
      widgetCard = GenerateVirtualCard();
    } else {
      widgetCard = VirtualCard(card: card);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: GenericAppBar(title: 'Meus Cartões'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'Cartão Físico',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'NOME',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('FIAP'),
                  ],
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'VALIDADE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('11/25'),
                  ],
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'FUNÇÃO',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Débito e Crédito'),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                widgetCard,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
