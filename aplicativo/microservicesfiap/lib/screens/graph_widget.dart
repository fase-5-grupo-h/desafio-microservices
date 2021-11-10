import 'package:flutter/material.dart';
import 'package:microservicesfiap/model/payment.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/*class GraphWidget extends StatelessWidget {
  //GraphWidget({required this.pagList});



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: charts.BarChart(
        seriesList,
        animate: false,
      ),
    );
  }
}*/

class GraphWidget extends StatefulWidget {
  const GraphWidget({Key? key}) : super(key: key);

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  final List<Payment> pagList = [
    Payment(categoria: 'Imposto', valor: 4690.90),
    Payment(categoria: 'Fornecedor', valor: 5842.70),
    Payment(categoria: 'Imposto', valor: 985.75),
    Payment(categoria: 'Imposto', valor: 4690.90),
    Payment(categoria: 'Fornecedor', valor: 27950.50),
  ];

  List<charts.Series<Payment, String>> seriesList = [];

  void _makeData() {
    seriesList.add(
      charts.Series<Payment, String>(
        id: 'Pagamentos',
        data: pagList,
        domainFn: (Payment pay, _) => pay.categoria,
        measureFn: (Payment pay, _) => pay.valor,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
      ),
    );
  }

  @override
  void initState() {
    _makeData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: charts.BarChart(
        seriesList,
        animate: false,
      ),
    );
  }
}
