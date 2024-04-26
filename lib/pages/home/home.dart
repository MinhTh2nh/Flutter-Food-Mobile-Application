import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/product_tile.dart';
import '../../model/cart_model.dart';
import 'package:provider/provider.dart';
import '../../pages/product_detail_page.dart';
import 'small_components/categories.dart';
import 'small_components/discount_banner.dart';
import 'small_components/special_offers.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('lib/images/main_image.png'),
            Column( // Wrap DiscountBanner and Categories in a Column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DiscountBanner(),
                Categories(),
              ],
            ),
            SpecialOffers(),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "New Arrivals",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),
            Consumer<CartModel>(
              builder: (context, cartModel, child) {
                if (cartModel.shopItems.isEmpty) {
                  // Display loading indicator until products are fetched
                  return Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartModel.shopItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    var product = cartModel.shopItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(index: index),
                          ),
                        );
                      },
                      child: ProductTile(
                        itemName: product['name'],
                        itemPrice: product['itemPrice'],
                        imagePath: product['imagePath'],
                        onPressed: () =>
                            Provider.of<CartModel>(context, listen: false)
                                .addItemToCart(index),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}