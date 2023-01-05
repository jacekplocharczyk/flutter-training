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

Future<http.Response> checkProcessingStatus(String audioUrl) async {
  http.Response response;
  var i = 0;

  do {
    response = await http.get(Uri.parse(audioUrl));
    if (response.statusCode == 502) {
      await Future.delayed(const Duration(seconds: 1));
    } else {
      return response;
    }
    i++;
  } while (i < 5);

  return response;
}

Future<Map<String, String>?> scheduleGeneratingAudio(String text) async {
  var response = await sendRequestGenerate(text);
  if (response.statusCode == 200) {
    Map<String, String> responseMap = Map.castFrom(json.decode(response.body));
    return responseMap;
  }
  return null;
}
