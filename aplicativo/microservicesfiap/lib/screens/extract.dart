import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:microservicesfiap/model/payment.dart';
import 'package:microservicesfiap/screens/generic_widgets/generic_app_bar.dart';
import 'package:microservicesfiap/screens/generic_widgets/generic_list_view_item.dart';

class Extract extends StatefulWidget {
  @override
  _ExtractState createState() => _ExtractState();
}

class _ExtractState extends State<Extract> {
  Payment ultPag = Payment(categoria: 'Imposto', valor: 4690.90);

  List<Payment> pagList = [
    Payment(categoria: 'Imposto', valor: 4690.90),
    Payment(categoria: 'Fornecedor', valor: 5842.70),
    Payment(categoria: 'Imposto', valor: 985.75),
    Payment(categoria: 'Imposto', valor: 4690.90),
    Payment(categoria: 'Fornecedor', valor: 27950.50),
    Payment(categoria: 'Fornecedor', valor: 1250.90),
    Payment(categoria: 'Imposto', valor: 5421.50),
    Payment(categoria: 'Fornecedor', valor: 27950.50),
    Payment(categoria: 'Fornecedor', valor: 1250.90),
    Payment(categoria: 'Imposto', valor: 5421.50)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: GenericAppBar(title: 'Extrato'),
      ),
      body: Container(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: pagList.length,
          itemBuilder: (BuildContext context, int index) {
            return GenericListViewItem(
                header: pagList[index].categoria,
                value: pagList[index].valor,
                data: DateTime.now().toString());
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: double.infinity,
            );
          },
        ),
      ),
    );
  }
}