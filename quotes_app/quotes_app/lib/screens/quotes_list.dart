import 'package:flutter/material.dart';

class QuoteListPage extends StatelessWidget {
  const QuoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Quotes'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: const Text(
              'The only way to do great work is to love what you do.',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('- Steve Jobs'),
          ),
        ),
      ),
    );
  }
}