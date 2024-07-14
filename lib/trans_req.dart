import 'dart:convert';
import 'package:http/http.dart'as http;

class TranslationService {
  final String apiKey = 'AIzaSyCRk9UsJeOygk7abBCJqN_U5ITBqvGkg9M';

  Future<String> translate(String text, String targetLanguage) async {
    final String url =
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey';

    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'q': text,
        'target': targetLanguage,
        'format': 'text',
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Failed to translate text');
    }
  }
}
