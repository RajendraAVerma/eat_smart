import 'dart:convert';

import 'package:api_repository/api_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class ApiV1Repository extends ApiRepository {
  final googleCloudVision =
      "https://us-central1-rent-rocks.cloudfunctions.net/getImageLabel";

  String usdaGovEndPoint(String foodName) {
    return "https://api.nal.usda.gov/fdc/v1/foods/search?query=${foodName}&pageSize=1&api_key=MbsrjC89NMdhdbDn7Rwu5Mb6Sh1v4u5beYP8dayn";
  }

  @override
  Future<List<String>> getLabelsFromImageLink(String imageLink) async {
    List<String> foodNameList = [];
    final uri =
        Uri.parse(Uri.encodeFull('$googleCloudVision?imageLink=$imageLink'));
    final res = (await http.get(uri)).body;
    final jsonParse = json.decode(res) as List;
    print(jsonParse);
    jsonParse.forEach((element) {
      foodNameList.add(element['description'] ?? "");
    });
    return foodNameList;
  }

  @override
  Future<List<Map<String, dynamic>>> searchFoodFromName(String name) async {
    List<Map<String, dynamic>> list = [];
    final res = (await http.get(Uri.parse(usdaGovEndPoint(name)))).body;
    final jsonParse = json.decode(res) as Map<String, dynamic>;
    (jsonParse['foods'] as List).forEach((element) {
      list.add(element);
    });
    return list;
  }

  @override
  Future<String> generateResponseFromOpenAI(String prompt) async {
    const apiKey = "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";

    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $apiKey"
      },
      body: json.encode({
        "model": "text-davinci-003",
        "prompt": prompt,
        'temperature': 0.5,
        'max_tokens': 60,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    print(response.body);

    Map<String, dynamic> newresponse = jsonDecode(response.body);

    return newresponse['choices'][0]['text'];
  }
}
