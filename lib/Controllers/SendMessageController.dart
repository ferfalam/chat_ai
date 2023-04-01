import 'dart:convert';
import 'package:http/http.dart' as http;

class SendMessageController{
  static const String token = "<your-api-token>";

  sendChatMessage(message) async {
    var path = "https://api.openai.com/v1/chat/completions";
    return await getOpenAIResponse(path, message, token);
  }

  sendImageMessage(message) async {
    var path = "https://api.openai.com/v1/images/generations";
    return await getOpenAIImageResponse(path, message, token);
  }

  Future<String> getOpenAIResponse(String path, String message, String apiKey,) async {
    var url = Uri.parse(path);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    var body = {
      "model": "gpt-3.5-turbo",
      "messages" : [
          {"role": "user", "content": message}
      ]
    };
    var response = await http.post(url, headers: headers, body: jsonEncode(body));
    var json = jsonDecode(response.body);
    return json['choices'][0]['message']['content'];
  }

  Future<String> getOpenAIImageResponse(String path, String message, String apiKey) async {
    var url = Uri.parse(path);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    var body = {
       "prompt": message,
       "size": "256x256"
    };
    var response = await http.post(url, headers: headers, body: jsonEncode(body));
    var json = jsonDecode(response.body);
    return json['data'][0]['url'];
  }
}