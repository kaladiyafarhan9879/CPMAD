import 'package:flutter_test/flutter_test.dart';
import 'package:quotes_app/models/quotes_model.dart';

void main() {
  test('parses a quote response from the random quote API', () {
    final quote = Quotes.fromJson({
      'quote': 'Stay hungry, stay foolish.',
      'author': 'Steve Jobs',
    });

    expect(quote.q, 'Stay hungry, stay foolish.');
    expect(quote.a, 'Steve Jobs');
    expect(quote.h, '');
  });
}
