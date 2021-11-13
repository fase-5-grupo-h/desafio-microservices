import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:microservicesfiap/model/credit_card.dart';
import 'package:microservicesfiap/services/cartao_service.dart';
import 'package:microservicesfiap/utilities/constants.dart';
import 'package:microservicesfiap/utilities/util.dart';

class VirtualCard extends StatelessWidget {
  VirtualCard({required this.card});

  var requestedValue = MoneyMaskedTextController(initialValue: 0.00);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var format = DateFormat.yMd('pt_BR');

  final CreditCard card;

  var random = Random();
  //int randomCVV = random.nextInt(999);

  static Widget sizedBoxWidth = const SizedBox(width: 5.0);
  static Widget sizedBoxHeight = const SizedBox(height: 8.0);

  Future<String> registerBill(double valor) async {
    dynamic resgiterBill =
        await CartaoService().registerBill(valor, card.numeroCartao);

    print(resgiterBill != null);
    print(resgiterBill);

    if (resgiterBill != null) {
      CreditCard cardResponse = CreditCard.fromJsonSingle(resgiterBill);
      if (!cardResponse.ativo) {
        return 'OK';
      }
      return 'ERRO';
    } else {
      return 'ERRO';
    }
  }

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
              sizedBoxWidth,
              const Icon(
                Icons.credit_card_outlined,
                color: Colors.white,
                size: 25.0,
              ),
              sizedBoxWidth,
              const Text(
                "Cartão Virtual",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          sizedBoxHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //sizedBox,
              const Text(
                '  Número do Cartão:',
                style: kWidgetText,
              ),
              Text(
                '${card.numeroCartao}',
                style: kWidgetText,
              ),
            ],
          ),
          sizedBoxHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '  Saldo: ${Util.currencyFormatter.format(card.saldo)}',
                style: kWidgetText,
              ),
              Text(
                'CVV: ${random.nextInt(999)}',
                style: kWidgetText,
              )
            ],
          ),
          sizedBoxHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '  Expira em:',
                style: kWidgetText,
              ),
              Text(
                format.format(card.prazo),
                style: kWidgetText,
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Valor da Compra (R\$)'),
                    actions: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              textAlign: TextAlign.center,
                              controller: requestedValue,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  fontSize: 30.0,
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite algum valor';
                                } else if (double.parse(value
                                        .replaceAll('.', '')
                                        .replaceAll(',', '.')) <=
                                    1) {
                                  return 'O valor mínimo é de R\$ 1';
                                } else if (double.parse(value
                                        .replaceAll('.', '')
                                        .replaceAll(',', '.')) >
                                    card.saldo) {
                                  return 'O saldo máximo é de ${Util.currencyFormatter.format(card.saldo)}';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                child: const Text('REGISTRAR'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    //var response = await generateCard(double.parse(requestedValue));
                                    var response = await registerBill(
                                        double.parse(requestedValue.text
                                            .replaceAll('.', '')
                                            .replaceAll(',', '.')));
                                    if (!response.contains('OK')) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                              'Compra não registrada'),
                                          content: const Text(
                                              'Tente novamente mais tarde'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      var resp = response.toString();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title:
                                              const Text('Compra registrada'),
                                          content: Text(
                                              'A compra foi registrada com sucesso!'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.popAndPushNamed(
                                                      context, '/'),
                                              child: Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                child: Text('REGISTRAR COMPRA'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          )
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
