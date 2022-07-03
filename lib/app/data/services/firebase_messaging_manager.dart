import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/notificacao.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/app/widgets/notificacoes/dialog_notificacao_firebase.dart';

class FireBaseMessagingManager extends GetxService {
  late LoginController _controller;
  Future<FireBaseMessagingManager> init() async {
    _controller = Get.find<LoginController>();
    Future<void> _messageHandler(RemoteMessage evento) async {
      Notificacao notificacao = Notificacao.fromJson(evento);

      //if (notificacao.idDestinario != _controller.getLogin().id) return;
      _controller.notificacoes.insert(0, notificacao);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((evento) {
      Notificacao notificacao = Notificacao.fromJson(evento);
      //if (notificacao.idDestinario != _controller.getLogin().id) return;
      _controller.notificacoes.insert(0, notificacao);
      Get.dialog(DialogNotificacaoFirebase());
    });
    FirebaseMessaging.onBackgroundMessage(_messageHandler);

    FirebaseMessaging.onMessage.listen(_messageHandler);
    return this;
  }
}
