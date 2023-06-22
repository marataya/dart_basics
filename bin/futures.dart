import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Todo {
  Todo(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  factory Todo.fromJson(Map<String, dynamic> jsonMap) {
    return Todo(
      userId: jsonMap['userId'] as int?,
      id: jsonMap['id'] as int?,
      title: jsonMap['title'] as String?,
      completed: jsonMap['completed'] as bool?,
    );
  }

  @override
  String toString() {
    return 'Todo userId: $userId\nid: $id\ntitle: $title\ncompleted: $completed';
  }
}

void main() async {
  try {
    final url = 'https://jsonplaceholder.typicode.com/todos/1';
    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl);
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      HttpException('$statusCode');
    }

    final jsonString = response.body;
    dynamic jsonMap = jsonDecode(jsonString);
    assert(jsonMap.isEmpty == true);
    if (jsonMap.isEmpty) {
      throw HttpException('404');
    }
    final todo = Todo.fromJson(jsonMap);
    print(todo);
  } on SocketException catch (err) {
    print('SocketException: ' + err.toString());
  } on HttpException catch (err) {
    print('HttpException: ' + err.toString());
  }
  on FormatException catch (err) {
    print('FormatException: ' + err.toString());
  }
}
