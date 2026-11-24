import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../services/api_call.dart';

class ListTodo extends StatefulWidget {
  const ListTodo({super.key});

  @override
  State<ListTodo> createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {
  TextEditingController txtTitle = TextEditingController();
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  // ignore: strict_top_level_inference
  fetchTodos() async {
    todos.clear();
    todos.addAll(await APICall.fetchTodos());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Title",
                    ),
                    controller: txtTitle,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (txtTitle.text.isNotEmpty) {
                      APICall.addTodo(txtTitle.text);
                      fetchTodos();
                      txtTitle.clear();
                    }
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  value: todos[index].completed,
                  onChanged: (v) async {
                    await APICall.updateTodo(todos[index].id, v!);
                    fetchTodos();
                  },
                  title: Text(todos[index].task),
                  secondary: IconButton(
                    onPressed: () async {
                      await APICall.deleteTodo(todos[index].id);
                      fetchTodos();
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}