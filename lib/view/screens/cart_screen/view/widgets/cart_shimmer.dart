import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/widgets/shimmer.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return ListView.separated(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                kWidth10,
                const ShimmerWidget.rectangle(height: 100, width: 100),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ShimmerWidget.rectangle(height: 10, width: 50),
                      kHeight10,
                      const ShimmerWidget.rectangle(height: 10, width: 30),
                      kHeight10,
                      Row(
                        children: const [
                          ShimmerWidget.rectangle(height: 10, width: 30),
                          kWidth10,
                          ShimmerWidget.rectangle(height: 10, width: 30),
                          kWidth10,
                          ShimmerWidget.rectangle(height: 10, width: 30),
                        ],
                      ),
                      kHeight10,
                      Row(
                        children: [
                          const ShimmerWidget.circle(height: 20, width: 20),
                          kWidth10,
                          ShimmerWidget.rectangle(
                            height: 20,
                            width: 40,
                            radius: BorderRadius.circular(10),
                          ),
                          kWidth10,
                          const ShimmerWidget.circle(height: 20, width: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            kHeight10,
          ],
        );
      },
      itemCount: cartController.cartList?.products.length ?? 10,
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
