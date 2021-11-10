import 'package:flutter/material.dart';
import 'package:microservicesfiap/model/credit_card.dart';
import 'package:microservicesfiap/screens/virtual_card.dart';
import 'package:microservicesfiap/utilities/util.dart';

import 'generic_widgets/generic_app_bar.dart';

class CardDetails extends StatefulWidget {
  CardDetails({required this.card});

  final CreditCard card;

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  late CreditCard card;

  @override
  void initState() {
    card = widget.card;
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
                VirtualCard(card: card),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
