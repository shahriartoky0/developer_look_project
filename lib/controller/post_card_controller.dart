import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CardController extends GetxController {
  final RxDouble updatedRating = 3.0.obs;
  final RxBool showAllComments = false.obs;
}
