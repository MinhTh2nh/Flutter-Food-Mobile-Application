import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_mobile_app/pages/home.dart';
import 'package:food_mobile_app/pages/login.dart';
import 'package:food_mobile_app/pages/signup.dart';
import 'package:food_mobile_app/pages/products.dart';
import 'package:food_mobile_app/pages/settings.dart';
import 'package:food_mobile_app/pages/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:food_mobile_app/model/cart_model.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBEQoFBKiq8O39B7aCG3878KaaIpLKXlAc",
      appId: "1:947403145687:android:39a5f3daa0f66fe4cf0b92",
      messagingSenderId: "947403145687",
      projectId: "store-mobile-e2ebc",
    ),
  );
  runApp(const MyApp());
}

// void main() async {
//   runApp(const MyApp());
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignupPage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const Products(),
    const Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text(
            'D Baku',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                // Action for the first button
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
          ),
          Consumer<CartModel>(
            builder: (context, cart, child) => Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CartPage();
                        },
                      ),
                    ),
                    icon: const Icon(
                      Icons.shopping_basket,
                    ),
                  ),
                  if (cart.itemsCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          cart.itemsCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal.shade200,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Product',
            icon: Icon(Icons.shopping_bag),
          ),
          BottomNavigationBarItem(
            label: 'Setting',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
