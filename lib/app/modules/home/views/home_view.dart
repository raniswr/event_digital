import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:event_digital/app/component/grocery_item_tile.dart';
import 'package:event_digital/app/components/categories.dart';
import 'package:event_digital/app/components/discount_banner.dart';
import 'package:event_digital/app/components/home_header.dart';
import 'package:event_digital/app/components/icon_btn_with_counter.dart';
import 'package:event_digital/app/components/popular_product.dart';
import 'package:event_digital/app/data/services/user_services.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:event_digital/core/colors.dart';
import 'package:event_digital/core/style.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        // onPressed: () => Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return CartPage();
        //     },
        //   ),
        // ),
        onPressed: () {
          Get.toNamed(Routes.KERANJANG_PAGE);
        },
        child: const Icon(
          Icons.shopping_bag,
          color: Color.fromARGB(255, 35, 31, 31),
        ),
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return SingleChildScrollView(
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
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Category",
                  style: TextStyle(
                    fontFamily: 'Sathoshi',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              controller.allCategory != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          controller.allCategory?.data?.length ?? 0,
                          (index) => GestureDetector(
                                onTap: () {
                                  controller.setCategory(controller.allCategory?.data?[index].attributes?.name ?? '');
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      height: 66,
                                      width: 66,
                                      decoration: BoxDecoration(
                                        color: AppColors.blue.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        controller.allCategory?.data?[index].attributes?.name == 'Social'
                                            ? Icons.people_outline
                                            : controller.allCategory?.data?[index].attributes?.name == 'Corporate'
                                                ? Icons.corporate_fare_outlined
                                                : controller.allCategory?.data?[index].attributes?.name == 'Entertainment'
                                                    ? Icons.event
                                                    : controller.allCategory?.data?[index].attributes?.name == 'Charty'
                                                        ? Icons.logo_dev
                                                        : Icons.sports_baseball_outlined,
                                        color: AppColors.blue,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(controller.allCategory?.data?[index].attributes?.name ?? '', textAlign: TextAlign.center)
                                  ],
                                ),
                              )),
                    ).paddingAll(20)
                  : SizedBox.shrink(),
              DiscountBanner(),
              // PopularProducts(),

              // PopularProducts(),
              // recent orders -> show last 3
              HomeHeader().marginOnly(top: 30),
              GetBuilder<HomeController>(builder: (controller) {
                return SizedBox(
                    height: 800,
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: DynamicHeightGridView(
                        itemCount: controller.allProudct?.data?.length ?? 0,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        builder: (context, index) {
                          String? productName = controller.allProudct?.data?[index].attributes?.name;
                          int? productPrice = controller.allProudct?.data?[index].attributes?.price;
                          int? productId = controller.allProudct?.data?[index].id;
                          String? productImage = controller.allProudct?.data?[index].attributes?.images?.data?[index].attributes?.formats?.thumbnail?.url;

                          var leghtItem = controller.allProudct?.data?[index].attributes?.category?.data?.attributes?.name;
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                Routes.DETAIL_PRODUCT_PAGE,
                                arguments: {
                                  'productId': productId,
                                  'image': productImage,
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    offset: const Offset(0, 0.2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // productImage != null
                                  //           ?
                                  Column(
                                    children: [
                                      productImage != null
                                          ? ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                topRight: Radius.circular(16.0),
                                              ),
                                              child: Image.network(
                                                // productImage,
                                                'http://localhost:1337${productImage}',
                                                // 'http://localhost:1337/uploads/thumbnail_image_bd8b1b9dd6.jpeg',
                                                width: double.infinity,
                                                height: 160,
                                                fit: BoxFit.cover,
                                              ),
                                            ).marginOnly(bottom: 10)
                                          : SizedBox.shrink()
                                    ],
                                  ),

                                  // : const SizedBox.shrink(),
                                  SizedBox(
                                      child: Text(
                                    productName ?? '',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  )).marginOnly(left: 20),

                                  Text(
                                    controller.formatPrice(productPrice ?? 0),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      // color: kPrimaryColor,
                                    ),
                                  ).marginOnly(left: 20, bottom: 15),
                                ],
                              ),
                            ),
                          );
                        },
                      ).marginSymmetric(vertical: 20),
                    ));
              }),
            ],
          ),
        );
      }),
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
