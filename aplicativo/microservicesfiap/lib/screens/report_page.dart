import 'package:flutter/material.dart';
import 'package:microservicesfiap/model/payment.dart';

import 'generic_widgets/generic_app_bar.dart';
import 'graph_widget.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<Payment> pagList = [
    Payment(categoria: 'Imposto', valor: 4690.90),
    Payment(categoria: 'Fornecedor', valor: 5842.70),
    Payment(categoria: 'Imposto', valor: 985.75),
    Payment(categoria: 'Imposto', valor: 4690.90),
    Payment(categoria: 'Fornecedor', valor: 27950.50),
  ];

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: GenericAppBar(title: 'Relatório'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          5.0,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 500.0,
                  child: GraphWidget(
                      //pagList: pagList,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
