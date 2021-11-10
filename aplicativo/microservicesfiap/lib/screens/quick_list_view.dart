import 'package:flutter/material.dart';
import '../model/quick_view_item.dart';

class QuickListView extends StatelessWidget {
  final List<QuickViewItem> iconQuickViewList = [
    QuickViewItem('Pagar', Icons.payments_outlined, '/'),
    QuickViewItem('Extrato', Icons.receipt_outlined, '/extrato'),
    QuickViewItem('Cartão Virtual', Icons.credit_card_outlined, '/'),
    QuickViewItem('Histórico de\ncartões', Icons.credit_card_off_outlined,
        '/histcartoes'),
    //QuickViewItem('Cartão\nVirtual', Icons.credit_card_outlined),
    QuickViewItem('Agenda-\nmentos', Icons.query_builder_outlined, '/'),
    //QuickViewItem('Pagar3', Icons.payments_outlined),
    QuickViewItem('Ajuda', Icons.help_outline, '/'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: iconQuickViewList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 60,
              child: Column(
                children: [
                  TextButton(
                    child: Icon(iconQuickViewList[index].iconName,
                        color: Colors.black),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: const CircleBorder(),
                      minimumSize: const Size(100, 100),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, iconQuickViewList[index].rota);
                    },
                  ),
                  Text(
                    iconQuickViewList[index].menuItem,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 10,
            );
          },
        ),
      ),
    );
  }
}
