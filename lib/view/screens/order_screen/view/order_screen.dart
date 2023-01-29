import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:scotch/common/api/api_baseurl.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_and_order_address_payment_controller/cart_and_order_address_payment_controller.dart';
import 'package:scotch/view/screens/order_screen/model/order_enum.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/order_address_widget.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/order_bottom_widget.dart';
import 'package:scotch/view/screens/order_screen/view/widgets/row_order_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen(
      {super.key,
      required this.cartId,
      required this.productId,
      required this.screenCheck});

  final String cartId;
  final String productId;
  final OrderScreenEnum screenCheck;

  @override
  State<OrderScreen> createState() => _OrderPageScreenState();
}

class _OrderPageScreenState extends State<OrderScreen> {
  CoaController coaController = Get.put(CoaController());

  @override
  void initState() {
    final razorpay = coaController.razorpay;
    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS, coaController.handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, coaController.handlePaymentError);
    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET, coaController.handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    coaController.razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      coaController.getSingleCart(widget.productId, widget.cartId);
    });
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          "Order Summary",
          style: TextStyle(
            fontFamily: "Manrope",
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<CoaController>(
          init: coaController,
          builder: (controller) {
            return coaController.isLoadingo == true
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          OrderAddressWidget(
                              index: coaController.selectIndex,
                              value: coaController),
                          kHeight10,
                          ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                color: kWhitecolor,
                                child: Column(
                                  children: [
                                    kHeight10,
                                    Row(
                                      children: [
                                        kWidth10,
                                        Image(
                                          height: 100,
                                          width: 100,
                                          image: NetworkImage(
                                            widget.screenCheck ==
                                                    OrderScreenEnum
                                                        .normalOrderScreen
                                                ? '${ApiBaseUrl().baseUrl}/products/${coaController.cartList!.products[index].product.image[4]}'
                                                : '${ApiBaseUrl().baseUrl}/products/${coaController.cartModel[0].product.image[4]}',
                                          ),
                                        ),
                                        kWidth10,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.screenCheck ==
                                                      OrderScreenEnum
                                                          .normalOrderScreen
                                                  ? coaController
                                                      .cartList!
                                                      .products[index]
                                                      .product
                                                      .name
                                                  : coaController.cartModel[0]
                                                      .product.name,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Manrope',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            RatingBar.builder(
                                              initialRating: double.parse(
                                                widget.screenCheck ==
                                                        OrderScreenEnum
                                                            .normalOrderScreen
                                                    ? coaController
                                                        .cartList!
                                                        .products[index]
                                                        .product
                                                        .rating
                                                    : coaController.cartModel[0]
                                                        .product.rating,
                                              ),
                                              itemSize: 15,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              ignoreGestures: true,
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (startRating) {
                                                log(startRating.toString());
                                              },
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  widget.screenCheck ==
                                                          OrderScreenEnum
                                                              .normalOrderScreen
                                                      ? "${coaController.cartList!.products[index].product.offer}%Off"
                                                      : "${coaController.cartModel[0].product.offer}%Off",
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    fontFamily: "Manrope",
                                                  ),
                                                ),
                                                kWidth10,
                                                Text(
                                                  widget.screenCheck ==
                                                          OrderScreenEnum
                                                              .normalOrderScreen
                                                      ? "₹${coaController.cartList!.products[index].product.price}"
                                                      : "₹${coaController.cartModel[0].product.price}",
                                                  style: const TextStyle(
                                                    color: kGreyColor,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontFamily: "Manrope",
                                                  ),
                                                ),
                                                kWidth10,
                                                Text(
                                                  widget.screenCheck ==
                                                          OrderScreenEnum
                                                              .normalOrderScreen
                                                      ? "₹${(coaController.cartList!.products[index].product.price - coaController.cartList!.products[index].product.discountPrice).round()}"
                                                      : "₹${(coaController.cartModel[0].product.price - coaController.cartModel[0].product.discountPrice).round()}",
                                                  style: const TextStyle(
                                                    color: kRedColor,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Manrope",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    kHeight10,
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        Container(
                                          height: 25,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "${coaController.cartList!.products[index].qty}",
                                            textAlign: TextAlign.center,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    kHeight10
                                  ],
                                ),
                              );
                            },
                            itemCount: widget.screenCheck ==
                                    OrderScreenEnum.normalOrderScreen
                                ? coaController.cartList!.products.length
                                : 1,
                          ),
                          kHeight10,
                          Container(
                            color: kWhitecolor,
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'Price Details',
                                      style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                kHeight10,
                                RowOrderWidget(
                                  text: 'Price',
                                  text2: widget.screenCheck ==
                                          OrderScreenEnum.normalOrderScreen
                                      ? "₹${(coaController.cartList!.totalPrice - coaController.cartList!.totalDiscount).round()}"
                                      : "₹${(coaController.cartModel[0].product.price - coaController.cartModel[0].product.discountPrice).round()}",
                                  color: kRedColor,
                                ),
                                kHeight10,
                                const RowOrderWidget(
                                  text: 'Delivery Charges',
                                  text2: "Free Delivery",
                                  color: Colors.green,
                                ),
                                const Text(
                                  '--------------------------------------------------------------------------------',
                                ),
                                RowOrderWidget(
                                  text: 'Total Amout',
                                  text2: widget.screenCheck ==
                                          OrderScreenEnum.normalOrderScreen
                                      ? "₹${(coaController.cartList!.totalPrice - coaController.cartList!.totalDiscount).round()}"
                                      : "₹${(coaController.cartModel[0].product.price - coaController.cartModel[0].product.discountPrice).round()}",
                                ),
                                kHeight10,
                              ],
                            ),
                          ),
                          kHeight20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              kWidth15,
                              Icon(Icons.verified_user, color: Colors.grey),
                              Text(
                                'Safe and Secure Payments.Easy returns.100% \nAuthentic products',
                                style: TextStyle(
                                  color: kGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
      bottomNavigationBar: OrderBottomWidget(
        screenCheck: widget.screenCheck,
      ),
    );
  }
}
