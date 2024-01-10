import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project2/widgets/image_constant.dart';
import 'Setting_Page.dart';

class SearchPage extends StatefulWidget {
  final String searchQuery;

  const SearchPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> products = [
    {
      'name': 'Panadol',
      'pharmacyName': 'Pharmacy 1',
      'address': 'city street, building 1',
      'rating': 3.15,
      'phoneNumber': '+962 800 000 000',
      'price': '3 JD',
      'isFavorite': false,
    },



  ];


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
          children: [
        SafeArea(
        child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: Text(
                "Good Afternoon, Dania",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 222, 224, 232),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: IconButton(
                  icon: SvgPicture.asset(
                    ImageConstant.imgIconHeart,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search a product or a pharmacy",
                  hintStyle: TextStyle(color: Colors.black45),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 222, 224, 232),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(27.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white54.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70.0),
                    topRight: Radius.circular(70.0),
                  ),
                ),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
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
                            Icon(Icons.medication, size: 40, color: Color(0xFF4CA6C2)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product['name'] ?? 'N/A',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4CA6C2),
                                  ),
                                ),
                                IconButton(
                                  icon: SvgPicture.asset(
                                    product['isFavorite'] ?? false
                                        ? ImageConstant.imgIconHeartTeal30004
                                        : ImageConstant.imgIconHeart,
                                    width: 24.0,
                                    height: 24.0,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      product['isFavorite'] = !(product['isFavorite'] ?? false);
                                    });
                                  },
                                ),
                              ],
                            ),
                            Text(product['pharmacyName'] ?? 'N/A', style: TextStyle(color: Color(0xFF4CA6C2))),
                            Text(product['address'] ?? 'N/A', style: TextStyle(color: Color(0xFF4CA6C2))),
                            Text('Rating: ${product['rating'] ?? 'N/A'}', style: TextStyle(color: Color(0xFF4CA6C2))),
                            Text('Price: ${product['price'] ?? 'N/A'}', style: TextStyle(color: Color(0xFF4CA6C2))),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
