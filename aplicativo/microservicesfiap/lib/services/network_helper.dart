import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future postData(String jsonBody) async {
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Access-Control_Allow_Origin": "*",
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "PUT"
      },
      body: jsonBody,
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    print(response.toString());
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future putData(String jsonBody) async {
    //print(valor);
    print(url);

    http.Response response = await http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Access-Control_Allow_Origin": "*",
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "PUT"
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
