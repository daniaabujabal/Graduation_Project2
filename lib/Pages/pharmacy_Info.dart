import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project2/Pages/product_Info.dart';
import 'package:graduation_project2/services/models/FeedBack.dart';
import 'package:graduation_project2/services/models/Product.dart';
import 'package:graduation_project2/widgets/image_constant.dart';
import 'package:graduation_project2/services/models/Pharmacy.dart';

class PharmacyInfoPage extends StatelessWidget {
  final Pharmacy pharmacy;
  

  PharmacyInfoPage({Key? key, required this.pharmacy}) : super(key: key);
  

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
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Center(
                child: Text(
                  pharmacy.name,
                  style: TextStyle(
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
               child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildPharmacyInfoCard(context, pharmacy),

                    Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Products in ${pharmacy.name}',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      GestureDetector(
        onTap: () {
          showSearch(
            context: context,
            delegate: PharmacyProductSearchDelegate(pharmacy: pharmacy),
          );
        },
        child: Container(
          padding: EdgeInsets.all(8), 
          decoration: BoxDecoration(
            color: Color(0xFF55AFBC), 
            borderRadius: BorderRadius.circular(10), 
          ),
          child: Icon(
            Icons.search,
            size: 24, 
            color: Color(0xFF95E4D4), 
          ),
        ),
      ),
    ],
  ),
),    
 const SizedBox(height: 10), 
 const SizedBox(height: 10),

                   Container(
                      height: 140, 
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: pharmacy.products.length,
                        itemBuilder: (context, index) {
                          Product product = pharmacy.products[index];
                          return _buildProductCard(context, product, pharmacy);
                        },
                      ),
                   ),   
                                       const SizedBox(height: 10),
 
Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Customers Feedback',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    ],   
  ),
),
                    
                    
                    const SizedBox(height: 10),

                   Container(
              height: 140, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pharmacy.feedbacks.length,
                itemBuilder: (context, index) {
                  FeedBack feedback = pharmacy.feedbacks[index];
                  return _buildFeedbackCard(context, feedback, pharmacy);
                },
              ),
            ),
                
            
                        ],
                      ),
                    ), 
                    
              ),
        
           
        ),
          ]
        ),
        
      ),
      
      
    
    );
  }

  Widget _buildPharmacyInfoCard(BuildContext context, Pharmacy pharmacy) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pharmacy Info",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on, color: Color(0xFF55AFBC)),
                const SizedBox(width: 8),
                Text(pharmacy.address),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.access_time, color: Color(0xFF55AFBC)),
                const SizedBox(width: 8),
                Text(pharmacy.workingHours), 
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: Color(0xFF55AFBC)),
                const SizedBox(width: 8),
                Text(pharmacy.phoneNumber),
              ],
            ),
            const SizedBox(height: 10),
            _buildRatingRow(pharmacy.rating),
          ],
        ),
      ),
    );
  }
    Widget _buildFeedbackCard(BuildContext context, FeedBack feedback, Pharmacy pharmacy) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feedback.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CA6C2
),
),
            ),

const SizedBox(height: 10),
Text(
feedback.text,
style: TextStyle(color: Color(0xFF4CA6C2)),
),
const SizedBox(height: 10),
Row(
children: List.generate(5, (index) {
return Icon(
index < feedback.rating ? Icons.star : Icons.star_border,
color: Color(0xFF55AFBC),
);
}),
),
],
),
),
);
}
}

 Widget _buildRatingRow(double rating) {
  int fullStars = rating.floor();
  bool hasHalfStar = rating - fullStars >= 0.5;
  int maxStars = 5;

  return Row(
    children: List<Widget>.generate(maxStars, (index) {
      if (index < fullStars) {
        return Icon(Icons.star, color: Color(0xFF55AFBC));
      } else if (hasHalfStar && index == fullStars) {
        hasHalfStar = false; //one half star
        return Icon(Icons.star_half, color: Color(0xFF55AFBC));
      } else {
        return Icon(Icons.star_border, color: Color(0xFF55AFBC));
      }
    }),
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
            pharmacies: [pharmacy], 
          ),
        ),
      );
    },
    child:  Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.tradeName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CA6C2),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: ${product.publicPrice} JOD',
              style: TextStyle(color: Color(0xFF71CDD7)),
            ),
            const SizedBox(height: 10),
            
          ],
        ),
      ),
    )
    );
  }
class PharmacyProductSearchDelegate extends SearchDelegate<Product?> {
  final Pharmacy pharmacy;

  PharmacyProductSearchDelegate({required this.pharmacy});

  @override
  String get searchFieldLabel => 'Search a product in ${pharmacy.name}';

  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> matchQuery = [];
    for (Product product in pharmacy.products) {
      if (product.tradeName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final Product product = matchQuery[index];
        return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductInfoPage(
            product: product,
            pharmacies: [pharmacy], 
          ),
        ),
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.tradeName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CA6C2),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: ${product.publicPrice} JOD',
              style: TextStyle(color: Color(0xFF71CDD7)),
            ),
            const SizedBox(height: 10),
          
          
          ],
     
          
          
        ),
      ),
    ),
        );
    
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(); 
  }
}