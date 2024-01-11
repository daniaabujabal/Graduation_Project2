import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project2/Pages/pharmacy_Info.dart';
import 'package:graduation_project2/Pages/product_Info.dart';
import 'package:graduation_project2/services/api_service.dart';
import 'package:graduation_project2/widgets/image_constant.dart';

import '../services/models/Product.dart';
import '../services/models/Pharmacy.dart';


class DataSearch extends SearchDelegate {
  final ApiService apiService;
  final String initialQuery;
 String? selectedSort;
  Map<String, dynamic>? selectedFilters;
  DataSearch({this.initialQuery = ''}) : apiService = ApiService() {
    query = initialQuery; 
  }


  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
    IconButton(
      icon: Icon(Icons.sort),
      onPressed: () {
        _showSortingOptions(context);
      },
    ),
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        query = "";
        showSuggestions(context);
      },
    ),
  ];
}

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
  print('Selected Sort: $selectedSort');
     return FutureBuilder<List<dynamic>>(
      future: apiService.searchProductsAndPharmacies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No results found."));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final result = snapshot.data![index];
              if (result['type'] == 'product') {
                return _buildProductCard(context, result['data'], result['pharmacy']);
              } else if (result['type'] == 'pharmacy') {
                return _buildPharmacyCard(context, result['data']);
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (initialQuery.isNotEmpty) {
      return buildResults(context);
    } else {
      return const Center(child: Text("Search Products and Pharmacies"));
    }
  }

void _showSortingOptions(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sort By'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Price'),
              onTap: () {
                selectedSort = 'price';
                Navigator.pop(context);
                showResults(context);
              },
            ),
            ListTile(
              title: Text('Rating'),
              onTap: () {
                selectedSort = 'rating';
                Navigator.pop(context);
                showResults(context);
              },
            ),
          ],
        ),
      );
    },
  );
}


Widget _buildProductCard(BuildContext context, Product product, Pharmacy pharmacy) {
    
    return InkWell(
      onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductInfoPage(
            product: product,
            pharmacies: [pharmacy], // pass all pharmacies that have this product
          ),
        ),
      );
    },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10), 
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.cyan[100], 
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.local_pharmacy,
                        color: Color(0xFF4CA6C2), 
                        size: 30, 
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            product.tradeName,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4CA6C2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pharmacy.name,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4CA6C2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left:9.0),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.location_on, color: Colors.grey, size: 22),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        pharmacy.address,
                        style: const TextStyle(color: Colors.grey , fontSize: 14.0 ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.phone, color: Colors.grey, size: 22),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        pharmacy.phoneNumber,
                        style: const TextStyle(color: Colors.grey ,fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Spacer(),
                  Text(
                    '${product.publicPrice} JOD',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF4CA6C2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildPharmacyCard(BuildContext context, Pharmacy pharmacy) {
  return InkWell(
    onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PharmacyInfoPage(pharmacy: pharmacy),
          ),
        );    },
    child: Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.cyan[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.local_pharmacy,
                      color: Color(0xFF4CA6C2),
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        pharmacy.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CA6C2),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rating: ${pharmacy.rating.toString()}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                const Icon(Icons.location_on, color: Colors.grey, size: 22),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    pharmacy.address,
                    style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: <Widget>[
                const Icon(Icons.phone, color: Colors.grey, size: 22),
                const SizedBox(width: 5),
                Text(
                  pharmacy.phoneNumber,
                  style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}