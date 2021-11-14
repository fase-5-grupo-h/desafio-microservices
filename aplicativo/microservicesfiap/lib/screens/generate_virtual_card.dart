import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:microservicesfiap/services/cartao_service.dart';

class GenerateVirtualCard extends StatelessWidget {
  var requestedValue = MoneyMaskedTextController(initialValue: 0.00);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<String> generateCard(double valor) async {
    dynamic generate = await CartaoService().generateCartao(valor);

    print(generate != null);
    print(generate.toString());
    if (generate.toString().contains('sucesso')) {
      return 'OK';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Você não possui nenhum Cartão Virtual'),
            ],
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Valor do limite (R\$)'),
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
                                    .replaceAll(',', '.')) <
                                100) {
                              return 'O valor mínimo é de R\$ 100';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ElevatedButton(
                            child: const Text('Gerar Cartão'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                //var response = await generateCard(double.parse(requestedValue));
                                var response = await generateCard(double.parse(
                                    requestedValue.text
                                        .replaceAll('.', '')
                                        .replaceAll(',', '.')));

                                if (!response.contains('OK')) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Erro ao gerar cartão'),
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
                                      title: const Text('Cartão gerado!'),
                                      content: Text(
                                          'O cartão solicitado foi gerado com sucesso!'),
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
            child: Text('Gerar Cartão Virtual'),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          const SizedBox(
            width: 25.0,
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
