import 'package:get/get.dart';
import '../models/quotes_model.dart';
import '../services/api_call.dart';

class QuotesController extends GetxController {
  final ApiCall _apiCall = ApiCall();

  // Observable quote object and loading state
  var quote = Rxn<Quotes>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuote();
  }

  // Fetch new quote and update state
  void fetchQuote() async {
    isLoading.value = true;
    final result = await _apiCall.fetchRandomQuote();
    quote.value = result;
    isLoading.value = false;
  }
}
