import 'package:flutter/material.dart';
import 'package:graduation_project2/Pages/pharmacy_Info.dart';
import 'package:graduation_project2/services/models/Product.dart';
import 'package:graduation_project2/services/models/Pharmacy.dart';

class ProductInfoPage extends StatelessWidget {
  final Product product;
  final List<Pharmacy> pharmacies; 

  const ProductInfoPage({super.key, required this.product, required this.pharmacies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4BD8BB),
              Color(0xFF55AFBC),
              Color(0xFF5DAFCA),
            ],
            stops: [0.1, 0.25, 0.9],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Center(
                child: Text(
                  product.tradeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white54.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(70.0),
                    topRight: Radius.circular(70.0),
                  ),
                ),
               child: ListView(
                  children: [
                    _buildProductInfoCard(context, product),
                    _buildPharmaciesCard(context, pharmacies),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildProductInfoCard(BuildContext context, Product product) {

     return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Info",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF55AFBC),
              ),
            ),
             Text(product.description,style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),),
              const SizedBox(height: 8),
              Text('Dosage: ${product.amount} mg',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),), 
              const SizedBox(height: 8),
              Text('Price: ${product.publicPrice} JOD', style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              ),
            const SizedBox(height: 10),
            ],
          ),
        ),
      
    );
  }

  Widget _buildPharmaciesCard(BuildContext context, List<Pharmacy> pharmacies) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Available in",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF55AFBC),
              ),
            ),
            const SizedBox(height: 10),
            for (var pharmacy in pharmacies) _buildPharmacyTile(context, pharmacy),
          ],
        ),
      ),
    );
  }

  Widget _buildPharmacyTile(BuildContext context, Pharmacy pharmacy) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PharmacyInfoPage(pharmacy: pharmacy,),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            const Icon(Icons.local_pharmacy, color:Color(0xFF55AFBC)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pharmacy.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(pharmacy.address),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF55AFBC)),
          ],
        ),
      ),
    );
  }
}