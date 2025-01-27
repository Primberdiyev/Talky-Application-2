import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/group/models/group_message_model.dart';
import 'package:talky_aplication_2/routes/message_types.dart';
import 'package:talky_aplication_2/utils/important_texts.dart';
import 'package:uuid/uuid.dart';

class GroupChatProvider extends BaseChangeNotifier {
  final UserDataService userDataService = UserDataService.instance;
  final currentUser = UserDataService.instance.auth.currentUser;
  Future sendMessageGroup({
    required String msg,
    required String id,
    required UserModel? userModel,
  }) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final message = GroupMessageModel(
      id: userModel?.id ?? '',
      dateTime: DateTime.now(),
      message: msg,
      type: MessageTypes.text,
      imageUrl: userModel?.imgUrl,
    );

    try {
      await userDataService.sendMessageGroup(
        time: time,
        message: message,
        id: id,
      );
    } catch (e) {
      log('error sending message to goup $e');
    }
  }

  Future getImageGroup({required String groupId, UserModel? usermodel}) async {
    final picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        final imageFile = File(value.path);
        uploadImage(
          groupId: groupId,
          imageFile: imageFile,
          usermodel: usermodel,
        );
      }
    });
  }

  Future uploadImage({
    required imageFile,
    required String groupId,
    UserModel? usermodel,
  }) async {
    final imageName = const Uuid().v1();
    final refStorage = userDataService.firebaseStorage
        .ref()
        .child(ImportantTexts.groupImages)
        .child('$imageName.png');
    final uploadTask = await refStorage.putFile(imageFile ?? File(''));
    final imgUrl = await uploadTask.ref.getDownloadURL();
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final sentTime = DateTime.now();
    final message = GroupMessageModel(
      message: imgUrl,
      type: MessageTypes.image,
      dateTime: sentTime,
      id: usermodel?.id ?? "",
      imageUrl: usermodel?.imgUrl,
    );

    final ref = userDataService.firebaseFirestore.collection(
      'groups/$groupId/messages/',
    );
    await ref.doc(time).set(message.toJson());
  }
}
