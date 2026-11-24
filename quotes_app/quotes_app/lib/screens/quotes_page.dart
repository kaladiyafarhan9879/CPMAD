import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quotes_controller.dart';
import 'quotes_list.dart';

class QuotePage extends StatelessWidget {
  QuotePage({super.key});

  final QuotesController controller = Get.put(QuotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Get.to(() => const QuoteListPage());
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const CircularProgressIndicator();
            }

            final currentQuote = controller.quote.value;
            if (currentQuote == null) {
              return const Text(
                'Failed to load quote. Tap refresh button below.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.format_quote,
                  size: 60,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 16),
                Text(
                  '"${currentQuote.q}"',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  '- ${currentQuote.a}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.fetchQuote();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
