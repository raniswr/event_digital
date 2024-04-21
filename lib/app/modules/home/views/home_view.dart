import 'package:event_digital/app/component/grocery_item_tile.dart';
import 'package:event_digital/app/components/categories.dart';
import 'package:event_digital/app/components/discount_banner.dart';
import 'package:event_digital/app/components/home_header.dart';
import 'package:event_digital/app/components/icon_btn_with_counter.dart';
import 'package:event_digital/app/components/popular_product.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconBtnWithCounter(
          svgSrc: "assets/icons/Bell.svg",
          numOfitem: 3,
          press: () {},
        ).marginOnly(top: 5),
        centerTitle: false,
        actions: [
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PROFILE_PAGE);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CartPage();
            },
          ),
        ),
        child: const Icon(
          Icons.shopping_bag,
          color: Color.fromARGB(255, 35, 31, 31),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),

            // good morning bro
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Good morning,',
                style: TextStyle(
                  fontFamily: 'Sathoshi',
                ),
              ),
            ),

            const SizedBox(height: 4),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Create your Event Now!",
                style: TextStyle(
                  fontFamily: 'Sathoshi',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),

            const SizedBox(height: 24),

            // categories -> horizontal listview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Category",
                style: TextStyle(
                  fontFamily: 'Sathoshi',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Categories(),
            DiscountBanner(),
            PopularProducts(),

            // PopularProducts(),
            // recent orders -> show last 3
            HomeHeader().marginOnly(top: 30),
            GetBuilder<HomeController>(builder: (controller) {
              return SizedBox(
                height: 800,
                width: double.infinity,
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.shopItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return GroceryItemTile(
                        itemName: controller.shopItems[index][0],
                        itemPrice: controller.shopItems[index][1],
                        imagePath: controller.shopItems[index][2],
                        color: controller.shopItems[index][3],
                        onPressed: () {
                          Get.toNamed(Routes.DETAIL_PRODUCT_PAGE);
                          controller.addItemToCart(index);
                        });
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Let's order fresh items for you
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("My Cart",
                    style: TextStyle(
                      fontFamily: 'Sathoshi',
                    )),
              ),

              // list view of cart
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    padding: EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            // leading: Image.asset(
                            //   controller.cartItems[index][2],
                            //   height: 36,
                            // ),
                            title: Text(
                              controller.cartItems[index][0],
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Sathoshi',
                              ),
                            ),
                            subtitle: Text(
                              '\$' + controller.cartItems[index][1],
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Sathoshi',
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                controller.removeItemFromCart(index);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // total amount + pay now

              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(color: Colors.green[200]),
                          ),

                          const SizedBox(height: 8),
                          // total price
                          Text(
                            '\$${controller.calculateTotal()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      // pay now
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: const [
                            Text(
                              'Pay Now',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
