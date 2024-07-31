import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:event_digital/app/components/discount_banner.dart';
import 'package:event_digital/app/components/home_header.dart';
import 'package:event_digital/app/components/icon_btn_with_counter.dart';
import 'package:event_digital/app/data/model/model_product.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:event_digital/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          // numOfitem: 3,
          press: () {},
        ).marginOnly(top: 5),
        centerTitle: false,
        actions: [
          const SizedBox(width: 8),
          GetBuilder<HomeController>(builder: (controller) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.PROFILE_PAGE);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    controller.profile?.image ?? '',
                    width: 60,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ).marginOnly(right: 20),
            );
          }),
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

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Have a good day,',
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
                                        child: Image.asset(controller.allCategory?.data?[index].attributes?.name == 'Social'
                                            ? "assets/images/social-care.png"
                                            : controller.allCategory?.data?[index].attributes?.name == 'Profesional'
                                                ? "assets/images/team.png"
                                                : controller.allCategory?.data?[index].attributes?.name == 'Cultural'
                                                    ? "assets/images/cultural.png"
                                                    : controller.allCategory?.data?[index].attributes?.name == 'Charity'
                                                        ? "assets/images/solidarity.png"
                                                        : controller.allCategory?.data?[index].attributes?.name == 'Wedding'
                                                            ? "assets/images/wedding.png"
                                                            : "assets/images/sports.png")),
                                    const SizedBox(height: 4),
                                    Text(controller.allCategory?.data?[index].attributes?.name ?? '', textAlign: TextAlign.center)
                                  ],
                                ),
                              )),
                    ).paddingAll(20)
                  : const SizedBox.shrink(),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(text: "${controller.promotion?.data?.first.attributes?.title}\n"),
                      TextSpan(
                        text: "${controller.promotion?.data?.first.attributes?.description}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // PopularProducts(),

              // PopularProducts(),
              // recent orders -> show last 3
              const HomeHeader().marginOnly(top: 30),
              GetBuilder<HomeController>(builder: (controller) {
                return SizedBox(
                    height: 800,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: DynamicHeightGridView(
                        itemCount: controller.allProudct?.data?.length ?? 0,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        builder: (context, index) {
                          var data = controller.allProudct?.data?[index];
                          String? productName = data?.attributes?.name;
                          int? productPrice = data?.attributes?.price;
                          int? productId = data?.id;
                          ImageProduct? productImage = data?.attributes?.images;

                          // var leghtItem = data?.attributes?.category?.data?.attributes?.name;
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
                                      productImage?.data?.first.attributes?.url != null
                                          ? ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                topRight: Radius.circular(16.0),
                                              ),
                                              child: Image.network(
                                                // productImage,
                                                '${productImage?.data?.first.attributes?.url}',
                                                width: double.infinity,
                                                height: kIsWeb ? 250 : 160,
                                                fit: BoxFit.cover,
                                              ),
                                            ).marginOnly(bottom: 10)
                                          : const SizedBox.shrink()
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
              const Padding(
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
                    padding: const EdgeInsets.all(12),
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
                        child: const Row(
                          children: [
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
