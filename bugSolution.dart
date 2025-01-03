```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomException implements Exception {
  final String message;
  CustomException(this.message);
  @override
  String toString() {
    return message;
  }
}

Future<Map<String, dynamic>> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw CustomException('Failed to load data: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } on CustomException catch (e) {
    // Handle the custom exception
    print('Custom error: $e');
    rethrow; // or handle appropriately
  } on FormatException catch (e) {
    // Handle JSON format exceptions
    print('JSON format error: $e');
    rethrow; // or handle appropriately
  } catch (e) {
    // Handle other exceptions
    print('Unexpected error: $e');
    rethrow; // or handle appropriately
  }
}
```