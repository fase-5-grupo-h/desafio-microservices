import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:microservicesfiap/model/credit_card.dart';
import 'package:microservicesfiap/services/cartao_service.dart';
import 'package:microservicesfiap/utilities/constants.dart';
import 'package:microservicesfiap/utilities/util.dart';

import 'generic_widgets/generic_app_bar.dart';
import 'generic_widgets/generic_list_view_item.dart';

class AllCreditCards extends StatefulWidget {
  const AllCreditCards({Key? key}) : super(key: key);

  @override
  _AllCreditCardsState createState() => _AllCreditCardsState();
}

class _AllCreditCardsState extends State<AllCreditCards> {
  List<CreditCard> allCards = [CreditCard.emptyCard()];
  var format = DateFormat.yMd('pt_BR');

  @override
  void initState() {
    getAllCards().whenComplete(() {
      setState(() {});
    });
  }

  getAllCards() async {
    dynamic allCardsList = await CartaoService().getAllCards();
    print(allCardsList.toString());
    setState(() {
      print(allCardsList != null);

      if (allCardsList != null) {
        allCards = CreditCard.fromJsonList(allCardsList);
        allCards = allCards.reversed.toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: GenericAppBar(title: 'Histórico de Cartões'),
      ),
      body: ListView.builder(
        itemCount: allCards.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nº Cartão',
                        style: kWidgetAllCards,
                      ),
                      Text(
                        allCards[index].numeroCartao,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Saldo Restante:',
                        style: kWidgetAllCards,
                      ),
                      Text(
                        Util.currencyFormatter.format(allCards[index].saldo),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Expiração Original:',
                        style: kWidgetAllCards,
                      ),
                      Text(
                        format.format(allCards[index].prazo),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
