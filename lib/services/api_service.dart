
  import 'dart:convert';
  import 'package:flutter/services.dart' show rootBundle;
  import 'models/Product.dart';
  import 'models/Pharmacy.dart';

  class ApiService {
    Future<List<dynamic>> searchProductsAndPharmacies(String query,{String? sortBy}) async {
    final String jsonString = await rootBundle.loadString('assets/sample_data.json');
    final jsonResponse = json.decode(jsonString);
    List<dynamic> searchResults = [];

    // Search for pharmacies
    var pharmacies = jsonResponse['pharmacies'] as List;
    var matchedPharmacies = pharmacies.where((pharm) {
      return pharm['name'].toString().toLowerCase().contains(query.toLowerCase());
    }).map((e) => Pharmacy.fromJson(e)).toList();

    // Add matched pharmacies to the search results
    searchResults.addAll(matchedPharmacies.map((pharmacy) {
      return {
        'type': 'pharmacy',
        'data': pharmacy
      };
    }));

    // Search for products in all pharmacies
    for (var pharmacyJson in pharmacies) {
      var pharmacy = Pharmacy.fromJson(pharmacyJson);
      var matchedProducts = pharmacy.products.where((product) {
        return product.tradeName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      // Add matched products and their respective pharmacies to the search results
      searchResults.addAll(matchedProducts.map((product) {
        return {
          'type': 'product',
          'data': product,
          'pharmacy': pharmacy
        };
      }));
    }  if (sortBy != null) {
      if (sortBy == 'price') {
        // Debugging
        print('Before Sorting by price: $searchResults');
        searchResults.sort((a, b) => a['product'].publicPrice.compareTo(b['product'].publicPrice));
        print('After Sorting by price: $searchResults');
      } else if (sortBy == 'rating') {
        print('Before Sorting by rating: $searchResults');
        searchResults.sort((a, b) => b['product'].rating.compareTo(a['product'].rating));
        print('After Sorting by rating: $searchResults');
      }
    }

  return searchResults;
    }
  }