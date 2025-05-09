import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nabd/features/chats/data/models/message_model.dart';

abstract class ChatGetMessagesStates {
  static Stream<List<MessageModel>> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                final data = doc.data();
                return MessageModel.fromJson(data);
              }).toList(),
        );
  }
}
