import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_project2/widgets/image_constant.dart';
import 'Categories_Page.dart';
import 'Search_Page.dart';
import 'package:graduation_project2/services/models/Product.dart';
import 'package:graduation_project2/services/models/Pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';


import 'package:graduation_project2/Pages/search.dart';
import 'package:graduation_project2/Pages/wishlist_Page.dart';
import 'package:graduation_project2/Pages/pharmacy_Info.dart';

import 'package:graduation_project2/services/models/User.dart';
import 'package:graduation_project2/services/models/User_Product.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
//String apiKey = "AIzaSyDRJFyNMX431jprzZf_FcqJtH0eBaWwIuQ";
//String raduis = "3000";
//double longitude = ""


class _HomePageState extends State<HomePage> {
  final double cardBorderRadius = 25.0;
  TextEditingController searchController = TextEditingController();
List<dynamic> allPharmacies = [];
  List<Pharmacy> nearbyPharmacies = [];
  List<dynamic> highlyRatedPharmacies = [];
  Position? currentPosition;
  double radius = 5000; // Radius in meters to search for nearby pharmacies.
  bool locationPermissionDenied = false;
  User? currentUser; // Your logic to assign this
  

  @override
  void initState() {
    super.initState();
   loadPharmacies().then((_) {
    _determinePosition();
  });
   _fetchUserLocationFromApi();

    loadJson();
  }
  Future<void> loadPharmacies() async {
  String jsonString = await rootBundle.loadString('assets/sample_data.json');
  final jsonResponse = json.decode(jsonString);
  setState(() {
    allPharmacies = (jsonResponse['pharmacies'] as List)
        .map((pharmacyJson) => Pharmacy.fromJson(pharmacyJson))
        .toList();
  });
}


  Future<void> loadJson() async {
  String jsonString = await rootBundle.loadString('assets/sample_data.json');
  final jsonResponse = json.decode(jsonString);
  setState(() {
    allPharmacies = jsonResponse['pharmacies'] as List;
    highlyRatedPharmacies = allPharmacies.where((pharmacy) => pharmacy['rating'] >= 4.0).toList();
  });
  print(highlyRatedPharmacies); 
}

 Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => locationPermissionDenied = true);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => locationPermissionDenied = true);
      return;
    }

    // When permissions are granted continue to get the position.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
      locationPermissionDenied = false;
    });

    _getNearbyPharmacies();
  }

void _getNearbyPharmacies() {
  if (locationPermissionDenied || currentPosition == null) {
    setState(() {
      nearbyPharmacies = [];
    });
    return;
  }

  setState(() {
    nearbyPharmacies = allPharmacies.where((pharmacyJson) {
      final Map<String, dynamic> pharmacyMap = pharmacyJson as Map<String, dynamic>;

      final Pharmacy pharmacy = Pharmacy.fromJson(pharmacyMap);

      final distance = Geolocator.distanceBetween(
        currentPosition!.latitude,
        currentPosition!.longitude,
        pharmacy.latitude,
        pharmacy.longitude,
      );

      return distance <= radius;
    }).cast<Pharmacy>().toList();
  });
}

    Future<void> _fetchUserLocationFromApi() async {
    try {
    String userData = await rootBundle.loadString('assets/users.json');
    final userJsonResponse = json.decode(userData);
    List<dynamic> users = userJsonResponse['users'];
    currentUser = User.fromJson(users.first);

    if (currentUser != null) {
      setState(() {
        currentPosition = Position(
          latitude: currentUser!.latitude,
          longitude: currentUser!.longitude,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0, 
          headingAccuracy: 0.0,
        );
      });
    }
  } catch (e) {
    print("Error loading user data: $e");
  }
}

  Widget _buildNearbyPharmaciesList() {
    if (locationPermissionDenied) {
      return Center(child: Text('Location permission is denied.'));
    }
    if (nearbyPharmacies.isEmpty) {
      return Center(child: Text('No nearby pharmacies found.'));
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: nearbyPharmacies.length,
      itemBuilder: (context, index) {
        return _buildPharmacyCard(nearbyPharmacies[index]);
      },
    );
  }

  Widget _buildPharmacyCard(Pharmacy pharmacy) {
 return Card(
      child: Column(
        children: [
          
          Text(pharmacy.name),
          Text('${pharmacy.address} - ${pharmacy.phoneNumber}'),
          _buildRatingRow(pharmacy.rating),
        ],
      ),
    );  }


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
              Color(0xFF71CDD7),
              Color(0xFF5DAFCA),
            ],
            stops: [0.1, 0.23, 0.40],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
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
                        onPressed:() {
                           Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WishlistPage(searchQuery: "value")), 
        );
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: searchController,

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
             // onFieldSubmitted: (value) => _navigateToSearchPage(value),
                onTap:(){
                    showSearch(context: context, delegate: DataSearch());
                  }

               /* onFieldSubmitted: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(searchQuery: value),
                    ),
                  );
                },*/
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PageView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: GestureDetector(
                         onTap:(){
                           showSearch(
                             context: context,
                             delegate: DataSearch(initialQuery: 'Panadol'), // Panadol as the initial query
                           );
                             },
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ClipRRect(

                                  borderRadius: BorderRadius.circular(cardBorderRadius),
                                  child: Image.asset(ImageConstant.imgRectangle4, fit: BoxFit.cover),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(cardBorderRadius),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [Colors.black.withAlpha(100), Colors.transparent],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(16.0),
                                  child: const Text(
                                    'Panadol',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: GestureDetector(
                              onTap:(){
                               showSearch(
                                  context: context,
                                  delegate: DataSearch(initialQuery: 'Panadol'),
                                );
                              },
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(cardBorderRadius),
                                  child: Image.asset(ImageConstant.imgRectangle4149x329, fit: BoxFit.cover),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(cardBorderRadius),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [Colors.black.withAlpha(100), Colors.transparent],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Panadol',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Nearby',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                   
                     Container(
            height: 120,
            child: nearbyPharmacies.isEmpty
              ? Center(child: Text('No nearby pharmacies found.'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: nearbyPharmacies.length,
                  itemBuilder: (context, index) {
                    return _buildPharmacyCard(nearbyPharmacies[index]);
                  },
                ),
          ),
                                
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageConstant.imgIconStar,
                            width: 24,
                            height: 24,
                            //color: Color(0xFF4CA6C2),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Highly Rated',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                       itemCount: highlyRatedPharmacies.length, 
                        itemBuilder: (context, index) {
                        Map<String, dynamic> pharmacyMap = highlyRatedPharmacies[index];
    Pharmacy pharmacy = Pharmacy.fromJson(pharmacyMap);
                          return InkWell(
                            onTap: () {
                             Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PharmacyInfoPage(pharmacy: pharmacy,), 
          ),);
                            
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.93,
                              margin: EdgeInsets.only(left: 16, right: index == 9 ? 16 : 0),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(cardBorderRadius),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      width: 50,
                                      height: 50,
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
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                          pharmacy.name, 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF71CDD7),
                          ),
                                          ),
                      SizedBox(height: 10),
          _buildRatingRow(pharmacy.rating),
                                           Text(
                          pharmacy.description, 
                          style: TextStyle(
                            color: Color(0xFF71CDD7),
                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

Widget _buildRatingRow(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;
    int maxStars = 5;

    return Row(
  children: List<Widget>.generate(maxStars, (index) {
    Icon icon;
    if (index < fullStars) {
      icon = Icon(Icons.star, color: Color(0xFF55AFBC));
    } else if (hasHalfStar && index == fullStars) {
      icon = Icon(Icons.star_half, color: Color(0xFF55AFBC));
      hasHalfStar = false; 
    } else {
      icon = Icon(Icons.star_border, color: Color(0xFF55AFBC));
    }
    return icon;
  }),
);
  }
}
