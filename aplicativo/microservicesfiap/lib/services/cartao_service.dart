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
    CreditCard card = CreditCard(
      emailBeneficiario: kUserEmail,
      emailProprietario: kUserEmail,
      saldo: valor,
      prazo: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        (DateTime.now().day + 21),
      ),
    );

    String jsonBody = CreditCard.toJson(card);
    print(jsonBody);

    NetworkHelper networkHelper = NetworkHelper(url);

    var generateCard = await networkHelper.postData(jsonBody);

    return generateCard;

    /*http.Response response = await http.post(Uri.parse(url), body: jsonBody);

    if (response.statusCode == 200) {
      String dataResponse = response.body;
      dynamic data = jsonDecode(dataResponse);
      if (data != null) {}
    } else {
      print(response.statusCode);
    }*/
  }

  Future<dynamic> getAllCards() async {
    const String complementUrl = '/cartao';
    const url = kServerUrl + complementUrl;

    NetworkHelper networkHelper = NetworkHelper(url);

    var getAllCards = await networkHelper.getData();

    return getAllCards;
  }
}
