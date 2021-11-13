import 'package:http/http.dart' as http;
import 'package:microservicesfiap/model/credit_card.dart';
import 'package:microservicesfiap/services/network_helper.dart';
import 'package:microservicesfiap/utilities/constants.dart';
import 'dart:convert';

class CartaoService {
  final String serverUrl = kServerUrl;

  Future<dynamic> getCartaoAtivo() async {
    const String complementUrl = '/lista-cartao/true';
    const url = kServerUrl + complementUrl;

    NetworkHelper networkHelper = NetworkHelper(url);

    var callActiveCard = await networkHelper.getData();

    return callActiveCard;
  }

  Future<dynamic> generateCartao(double valor) async {
    const String complementUrl = '/cartao';
    const url = kServerUrl + complementUrl;

    //String jsonBody = CreditCard.toJson(card);
    String jsonBody = jsonEncode(<String, String>{
      'emailBeneficiario': kUserEmail,
      'emailProprietario': kUserEmail,
      'saldo': '$valor',
      'prazo': '${DateTime(
        DateTime.now().year,
        DateTime.now().month,
        (DateTime.now().day + 21),
      )}'
    });
    print(jsonBody);
    print('after jsonBody');
    NetworkHelper networkHelper = NetworkHelper(url);
    print('before generate');
    var generateCard = await networkHelper.postData(jsonBody);
    print(generateCard);
    print('after generate');
    return generateCard;
  }

  Future<dynamic> getAllCards() async {
    const String complementUrl = '/cartao';
    const url = kServerUrl + complementUrl;

    NetworkHelper networkHelper = NetworkHelper(url);

    var getAllCards = await networkHelper.getData();

    return getAllCards;
  }

  Future<dynamic> registerBill(double valorCompra, String cardNumber) async {
    String complementUrl = '/cartao/$cardNumber';
    var url = kServerUrl + complementUrl;

    Map<String, dynamic> jsonMap = <String, dynamic>{
      'valor': valorCompra.toStringAsFixed(2),
    };

    String jsonBody = jsonEncode(<String, String>{
      'valor': '$valorCompra',
    });

    print(jsonMap.toString());
    print(cardNumber);

    NetworkHelper networkHelper = NetworkHelper(url);

    var generateCard = await networkHelper.putData(jsonBody);
    print('Resposta');
    print(generateCard);
    return generateCard;
  }
}
