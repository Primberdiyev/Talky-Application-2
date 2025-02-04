import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';
import 'package:talky_aplication_2/features/chat/models/message_model.dart';
import 'package:talky_aplication_2/routes/message_types.dart';
import 'package:talky_aplication_2/utils/important_texts.dart';
import 'package:uuid/uuid.dart';

class ChatProvider extends BaseChangeNotifier {
  final userDataService = UserDataService.instance;
  String? lastMessage;
  File? imageFile;
  UserModel? receiverUser;
  bool isUserPressed = false;
  User? get currentUser => userDataService.auth.currentUser;
  String getConversatioId(String id) {
    final currentUserId = userDataService.auth.currentUser?.uid;
    return currentUserId.hashCode <= id.hashCode
        ? '${currentUserId}_$id'
        : '${id}_$currentUserId';
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(receiverId) {
    final chatId = getConversatioId(receiverId);
    return userDataService.getAllMessages(chatId);
  }

  Future addTOFriends(
    String receiverId,
  ) async {
    final myId = currentUser?.uid;
    await userDataService.setChattingDoc(
      id: myId ?? '',
      data: receiverId,
      options: SetOptions(
        merge: true,
      ),
    );
    await userDataService.setChattingDoc(
      id: receiverId,
      data: myId ?? '',
      options: SetOptions(
        merge: true,
      ),
    );
  }

  Future<void> sendMessage(String receiverId, String msg) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final sentTime = DateTime.now();
    final message = MessageModel(
      toId: receiverId,
      msg: msg,
      read: 'false',
      type: TypeMessage.text,
      fromId: currentUser?.uid ?? '',
      sent: time,
      sentTime: sentTime.toString(),
    );
    final chatId = getConversatioId(receiverId);

    try {
      await userDataService.sendMessage(
        chatId: chatId,
        time: time,
        messageModel: message,
      );
    } catch (_) {
      throw Exception();
    }
  }

  void changeReceiverUser({
    UserModel? newUser,
    String? receiverId,
  }) async {
    if (receiverId == null) {
      receiverUser = newUser;
    } else {
      final response = await userDataService.getUserDoc(id: receiverId);
      receiverUser = UserModel.fromJson(response.data() ?? {});
    }
    notifyListeners();
  }

  void getImage() async {
    final picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        uploadImage();
      }
    });
  }

  void uploadImage() async {
    final imageName = const Uuid().v1();
    final refStorage = userDataService.firebaseStorage
        .ref()
        .child('chatImages')
        .child('$imageName.png');
    final uploadTask = await refStorage.putFile(imageFile ?? File(''));
    final imgUrl = await uploadTask.ref.getDownloadURL();
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final sentTime = DateTime.now();

    final message = MessageModel(
      toId: receiverUser?.id ?? '',
      msg: imgUrl,
      read: 'false',
      type: TypeMessage.image,
      fromId: currentUser?.uid ?? '',
      sent: time,
      sentTime: sentTime.toString(),
    );
    final ref = userDataService.firebaseFirestore.collection(
      'chats/${getConversatioId(receiverUser?.id ?? '')}/messages/',
    );
    await ref.doc(time).set(message.toJson());
  }

  Future pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'jpg',
        'jpeg',
        'png',
        'mp3',
      ],
    );
    if (result != null) {
      TypeMessage type;
      final path = result.files.single;
      type = path.extension == 'mp3' ? TypeMessage.audio : TypeMessage.file;
      final file = File(path.path ?? '');
      final fileName = path.name;
      final refStorage = userDataService.firebaseStorage
          .ref()
          .child('chatFiles')
          .child(fileName);
      final uploadTask = await refStorage.putFile(file);
      final fileUrl = await uploadTask.ref.getDownloadURL();
      final time = DateTime.now().microsecondsSinceEpoch.toString();
      final sentTime = DateTime.now();

      final message = MessageModel(
        toId: receiverUser?.id ?? '',
        msg: fileUrl,
        read: 'false',
        type: type,
        fromId: currentUser?.uid ?? '',
        sent: time,
        sentTime: sentTime.toString(),
      );

      final ref = userDataService.firebaseFirestore.collection(
        'chats/${getConversatioId(receiverUser?.id ?? '')}/messages/',
      );
      await ref.doc(time).set(message.toJson());
    }
  }

  Future<List<Map<String, dynamic>>> getImages(String receiverId) async {
    final querySnapshot = await userDataService.firebaseFirestore
        .collection('chats/${getConversatioId(receiverId)}/messages')
        .where(MessageTypes.type, isEqualTo: MessageTypes.image)
        .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Stream<Map<String, String>> getLastMessageWithTime(String id) {
    return userDataService.firebaseFirestore
        .collection('chats/${getConversatioId(id)}/messages')
        .orderBy(ImportantTexts.sent, descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();

        return {
          ImportantTexts.msg: data[ImportantTexts.msg] ?? '',
          ImportantTexts.sentTime: data[ImportantTexts.sentTime] ?? '',
        };
      } else {
        return {ImportantTexts.msg: '', ImportantTexts.sentTime: ''};
      }
    });
  }

  void changeUserPressed() {
    isUserPressed = !isUserPressed;
    notifyListeners();
  }
}
