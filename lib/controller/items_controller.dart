// import 'package:get/get.dart';
// import 'package:ontrend_food_and_e_commerce/model/item_model.dart';
// import 'package:ontrend_food_and_e_commerce/repository/item_repository.dart';

// class ItemsController extends GetxController {
//   RxBool isItemsLoading = RxBool(false);
//   RxList<ItemModel> itemsList = RxList();
//   Future<void> getItems(String userId) async {
//     isItemsLoading.value = true;
//     itemsList.clear();
//     itemsList.value = await ItemRepository.getItems(userId);
//     isItemsLoading.value = false;
//   }
// }






// // class ItemsController extends GetxController {
// //   var itemsList = <ItemModel>[].obs;
// //   var isItemsLoading = false.obs;

// //   void getItems() async {
// //     isItemsLoading(true);
// //     try {
// //       itemsList.value = await ItemRepository.getItems();
// //     } finally {
// //       isItemsLoading(false);
// //     }
// //   }
// // }
