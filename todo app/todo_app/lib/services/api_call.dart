// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import '../models/todo_model.dart';

class APICall {
  static const String _baseUrl =
      'https://node-todo-api-yjo3.onrender.com/todos/';

  static Future<_ApiResponse> _send(
    String method,
    Uri uri, {
    Map<String, dynamic>? body,
  }) async {
    final client = HttpClient();
    try {
      final request = await client.openUrl(method, uri);
      request.headers.contentType = ContentType.json;
      if (body != null) {
        request.write(jsonEncode(body));
      }

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      return _ApiResponse(
        response.statusCode,
        response.reasonPhrase,
        responseBody,
      );
    } finally {
      client.close(force: true);
    }
  }

  // 1. GET - Fetch Todos
  static Future<dynamic> fetchTodos() async {
    final response = await _send('GET', Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      print(response.body);
      final todo = todoFromJson(response.body);
      print(todo.length);
      return todo;
    } else {
      print(response.reasonPhrase);
    }
  }

  // 2. POST - Add Todo
  static Future<void> addTodo(String title) async {
    final response = await _send(
      'POST',
      Uri.parse(_baseUrl),
      body: {'task': title, 'id': DateTime.now().toIso8601String()},
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  // 3. DELETE - Delete Todo
  static Future<void> deleteTodo(String id) async {
    final response = await _send(
      'DELETE',
      Uri.parse('$_baseUrl${Uri.encodeComponent(id)}'),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  // 4. PUT - Update Todo Status
  static Future<void> updateTodo(String id, bool completed) async {
    final response = await _send(
      'PUT',
      Uri.parse('$_baseUrl${Uri.encodeComponent(id)}'),
      body: {'completed': completed},
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}

class _ApiResponse {
  const _ApiResponse(this.statusCode, this.reasonPhrase, this.body);

  final int statusCode;
  final String reasonPhrase;
  final String body;
}