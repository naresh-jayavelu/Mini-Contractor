import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/reference/cardcontroller.dart';
import 'package:mini_contractor_2/reference/dummy.dart';
import 'package:mini_contractor_2/reference/shottingcontroller.dart';

class ShoppingPage extends StatelessWidget {
  final shoppingController=Get.put(ShoppingController());
  final cartcontroller=Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(children: [
          Expanded(
          child: GetX<ShoppingController>(
            builder: (controller) {
              return ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context,index){
                return  Card(
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${controller.products[index].productName}',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                          '${controller.products[index].productDescription}'),
                                    ],
                                  ),
                                  Text('\$${controller.products[index].price}',
                                      style: TextStyle(fontSize: 24)),
                                ],
                              ),
                              ElevatedButton(
            onPressed: () {
              // Navigate to the ShoppingPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dummy()),
              );
            },
            child: Text("Press"),
          ),
                              ElevatedButton(
                                onPressed: () {
                                  cartcontroller
                                      .addToCart(controller.products[index]);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: customColor, // Background color
                                  textStyle: TextStyle(color: customColor), // Text color
                                ),
                                child: Text('Add to Cart'),
                              ),
                              Obx(() => IconButton(
                                    icon: controller
                                            .products[index].isFavorite.value
                                        ? Icon(Icons.check_box_rounded) 
                                        : Icon(Icons
                                            .check_box_outline_blank_outlined),
                                    onPressed: () {
                                      controller.products[index].isFavorite
                                          .toggle();
                                    },
                                  ))
                            ],
                          ),
                        ),
                      );
              });
            }
          ),
        ),
        GetX<CartController>(
          builder: (controller) {
            return Text('total amount: \$ ${controller.totaPrice}');
          }
        ),
        const SizedBox(height: 100,)
        ]),
      ),
    );
  }
}