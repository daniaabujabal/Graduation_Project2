  import 'dart:convert';
  import 'package:graduation_project2/services/models/FeedBack.dart';
import 'package:http/http.dart' as http;

  import 'package:flutter/services.dart' show rootBundle;
  import 'models/Product.dart';
  import 'models/Pharmacy.dart';

 class ApiService {

  Future<List<dynamic>> searchProductsAndPharmacies(String query, {String? sortBy}) async {
    final String jsonString = await rootBundle.loadString('assets/sample_data.json');
    final jsonResponse = json.decode(jsonString);
    List<dynamic> searchResults = [];

    // Search for pharmacies and products
    var pharmacies = jsonResponse['pharmacies'] as List;
    List<Pharmacy> matchedPharmacies = [];
    List<dynamic> matchedProducts = [];

    for (var pharmacyJson in pharmacies) {
      var pharmacy = Pharmacy.fromJson(pharmacyJson);

      // Check if the pharmacy name matches the query
      if (pharmacy.name.toLowerCase().contains(query.toLowerCase())) {
        matchedPharmacies.add(pharmacy);
      }

      // Check if any product in the pharmacy matches the query
      var pharmacyProducts = pharmacy.products.where((product) {
        return product.tradeName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      if (pharmacyProducts.isNotEmpty) {
        matchedProducts.addAll(pharmacyProducts.map((product) {
          return {
            'type': 'product',
            'data': product,
            'pharmacy': pharmacy
          };
        }));
      }
    }

    if (sortBy == 'rating') {
      matchedPharmacies.sort((a, b) => b.rating.compareTo(a.rating));
    }

    
    if (sortBy == 'price') {
      matchedProducts.sort((a, b) => a['data'].publicPrice.compareTo(b['data'].publicPrice));
    }

    searchResults.addAll(matchedPharmacies.map((pharmacy) => {
      'type': 'pharmacy',
      'data': pharmacy
    }));
    searchResults.addAll(matchedProducts);

    return searchResults;
  }

  Future<List<FeedBack>> fetchFeedbackForPharmacy(int pharmacyId) async {
    var url = Uri.parse('https://apo.com/feedback');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> feedbackJson = json.decode(response.body);
      return feedbackJson.map((json) => FeedBack.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load feedback');
    }
  }
}

