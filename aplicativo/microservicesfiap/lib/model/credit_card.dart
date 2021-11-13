import 'package:microservicesfiap/utilities/constants.dart';

class CreditCard {
  CreditCard({
    required this.emailBeneficiario,
    required this.emailProprietario,
    required this.saldo,
    required this.prazo,
    this.ativo = false,
    this.numeroCartao = '',
  });

  final bool ativo;
  final String numeroCartao;
  final String emailProprietario;
  final String emailBeneficiario;
  final double saldo;
  final DateTime prazo;

  static String toJson(CreditCard cartao) {
    Map<String, dynamic> jsonMap = <String, dynamic>{
      "emailProprietario": "${cartao.emailProprietario}",
      "emailBeneficiario": "${cartao.emailBeneficiario}",
      "saldo": "${cartao.saldo}",
      "prazo": "${cartao.prazo}",
    };

    return jsonMap.toString();
  }

  static CreditCard emptyCard() {
    return CreditCard(
        emailBeneficiario: kUserEmail,
        emailProprietario: kUserEmail,
        saldo: 0,
        prazo: DateTime.now(),
        numeroCartao: '');
  }

  factory CreditCard.fromJsonSingle(dynamic json) {
    print('Entrou');
    return CreditCard(
      emailBeneficiario: json['emailBeneficiario'],
      emailProprietario: json['emailProprietario'],
      saldo: double.parse(json['saldo'].toString()),
      prazo: DateTime.parse(json['prazo'].toString()),
      ativo: json['ativo'],
      numeroCartao: json['numeroCartao'].toString(),
    );
  }

  factory CreditCard.fromJson(dynamic json) {
    print('Entrou');
    return CreditCard(
      emailBeneficiario: json[0]['emailBeneficiario'],
      emailProprietario: json[0]['emailProprietario'],
      saldo: double.parse(json[0]['saldo'].toString()),
      prazo: DateTime.parse(json[0]['prazo'].toString()),
      ativo: json[0]['ativo'],
      numeroCartao: json[0]['numeroCartao'].toString(),
    );
  }

  static List<CreditCard> fromJsonList(dynamic json) {
    List<CreditCard> ccList = [];

    json.forEach(
      (cc) => {
        ccList.add(
          CreditCard(
            emailBeneficiario: cc['emailBeneficiario'],
            emailProprietario: cc['emailProprietario'],
            saldo: double.parse(cc['saldo'].toString()),
            prazo: DateTime.parse(cc['prazo'].toString()),
            ativo: cc['ativo'],
            numeroCartao: cc['numeroCartao'].toString(),
          ),
        ),
      },
    );

    return ccList;
  }

  @override
  String toString() {
    return 'ativo: ${ativo}, numeroCartao: ${numeroCartao}, emailProprietario:  ${emailProprietario}, emailBeneficiario: ${emailBeneficiario},' +
        'saldo: ${saldo}, prazo: ${prazo}';
  }
}
