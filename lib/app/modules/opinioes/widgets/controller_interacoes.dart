import 'package:get/get.dart';

class InteracaoController extends GetxController {
  final _isLiked = 2.obs;
  get isLiked => _isLiked.value;
  set isLiked(value) => _isLiked.value = value;
}
