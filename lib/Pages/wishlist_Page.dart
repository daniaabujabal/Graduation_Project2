import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project2/widgets/image_constant.dart';
import 'package:graduation_project2/services/models/Product.dart';
import 'package:graduation_project2/services/models/User.dart';

class WishlistPage extends StatefulWidget {
  final String searchQuery;

  const WishlistPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {





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
                "Wishlist",
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
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white54.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70.0),
                  topRight: Radius.circular(70.0),
                ),
              ),
              child: Center(
                child: Text("Wishlist Items "),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}