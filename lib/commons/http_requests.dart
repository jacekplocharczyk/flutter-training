import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> sendRequestGenerate(String text) async {
  return await http.post(
    Uri.parse('https://tts-router-tne4pwqira-ew.a.run.app/generate'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'raw_text': text,
    }),
  );
}

Future <String?> scheduleGeneratingAudio(String text) async {
  String? itemId;
  var response = await sendRequestGenerate(text);
  if (response.statusCode == 200) {
    itemId = jsonDecode(response.body);
  }
  return itemId;
}
