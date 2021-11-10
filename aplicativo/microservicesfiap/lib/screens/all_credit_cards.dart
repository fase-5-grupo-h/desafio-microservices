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
  static Widget sizedBox = const SizedBox(width: 5.0);

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
            color: Colors.grey,
            child: Column(
              children: [
                Row(
                  children: [
                    sizedBox,
                    Text(
                      'Número do Cartão: ${allCards[index].numeroCartao}',
                      style: kWidgetText,
                    ),
                  ],
                ),
                Row(
                  children: [
                    sizedBox,
                    Text(
                      'Saldo Original: ${Util.currencyFormatter.format(allCards[index].saldo)}',
                      style: kWidgetText,
                    ),
                  ],
                ),
                Row(
                  children: [
                    sizedBox,
                    Text(
                      'Expiração Original: ${format.format(allCards[index].prazo)}',
                      style: kWidgetText,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
