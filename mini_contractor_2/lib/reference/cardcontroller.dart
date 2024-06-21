import 'package:get/get.dart';
import 'package:mini_contractor_2/reference/shoppingmodel.dart';

class CartController extends GetxController{
 var cartiteams=<Product>[].obs;
 int get count=>cartiteams.length;
 double get totaPrice=>cartiteams.fold(0,(sum,item)=>sum+item.price);
 
 

void addToCart(Product product){
  cartiteams.add(product);
 }

void removeFromCart(int id){
  cartiteams.removeWhere((item) =>item.id==id);
}

}