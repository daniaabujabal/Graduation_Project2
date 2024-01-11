import 'dart:convert';
  import 'package:http/http.dart' as http;
  
  //import 'package:flutter/services.dart' show rootBundle;
  //import 'models/Product.dart';
  import 'models/Pharmacy.dart';



class ApiService {
  final String baseUrl = "https://apiurl"; 

  Future<List<dynamic>> searchProductsAndPharmacies(String query, {String? sortBy}) async {
    var url = Uri.parse('$baseUrl'); 
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<dynamic> searchResults = [];
    // Search for pharmacies

      var pharmacies = jsonResponse['pharmacies'] as List;
      var matchedPharmacies = pharmacies.where((pharm) {
        return pharm['name'].toString().toLowerCase().contains(query.toLowerCase());
      }).map((e) => Pharmacy.fromJson(e)).toList();

    // add matched pharmacies to the search results
      searchResults.addAll(matchedPharmacies.map((pharmacy) {
        return {
          'type': 'pharmacy',
          'data': pharmacy
        };
      }));

      for (var pharmacyJson in jsonResponse['pharmacies']) {
        var pharmacy = Pharmacy.fromJson(pharmacyJson);
        var matchedProducts = pharmacy.products.where((product) {
          return product.tradeName.toLowerCase().contains(query.toLowerCase());
        }).toList();

      // add matched products and their respective pharmacies to the search results
        searchResults.addAll(matchedProducts.map((product) {
          return {
            'type': 'product',
            'data': product,
            'pharmacy': pharmacy
          };
        }));
      }

      if (sortBy != null) {
        if (sortBy == 'price') {
          searchResults.sort((a, b) => a['data'].publicPrice.compareTo(b['data'].publicPrice));
        } else if (sortBy == 'rating') {
          searchResults.sort((a, b) => b['data'].rating.compareTo(a['data'].rating));
        }
      }

      return searchResults;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }
}