import 'package:event_digital/app/components/product_card.dart';
import 'package:event_digital/app/models/Product.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../components/product_card.dart';
// import '../../../models/Product.dart';
// import '../../details/details_screen.dart';
// import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Products",
            press: () {
              // Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  if (demoProducts[index].isPopular) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ProductCard(
                          product: demoProducts[index],
                          onPress: () {
                            Get.toNamed(Routes.DETAIL_PRODUCT_PAGE);
                          }),
                    );
                  }

                  return const SizedBox.shrink(); // here by default width and height is 0
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }
}
