import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nabd/core/utls/cache_helper.dart';
import 'package:nabd/features/chats/data/models/message_model.dart';
import 'package:nabd/features/chats/data/repo/send_notification.dart';

abstract class ChatSendMessageStates {
  static Future<void> sendMessage(String receiverId, String message , String name , int imageUrl ) async {
    final String currentUserID;
    if (CacheHelper.getData(key: 'userName') == 'Guest') {
      currentUserID = CacheHelper.getData(key: 'guestuId');
    } else {
      currentUserID = CacheHelper.getData(key: 'uId');
    }
    final Timestamp timestamp = Timestamp.now();

    MessageModel messageModel = MessageModel(
      senderId: currentUserID,
      receiverId: receiverId,
      message: message,
      time: timestamp,
    );

    List<String> ids = [currentUserID, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // Add message to Firestore
    await FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) async {
          final guestDoc =
              await FirebaseFirestore.instance
                  .collection('guests')
                  .doc(currentUserID)
                  .get();
          if (guestDoc.exists) {
            final guestData = guestDoc.data() as Map<String, dynamic>;
            if (!guestData['doctorsId'].contains(receiverId)) {
              {
                await FirebaseFirestore.instance
                    .collection('guests')
                    .doc(currentUserID)
                    .update({
                      'doctorsId': FieldValue.arrayUnion([receiverId]),
                    });
              }
            }
          }
          final doctorDoc =
              await FirebaseFirestore.instance
                  .collection('doctors')
                  .doc(receiverId)
                  .get();
          if (doctorDoc.exists) {
            final doctorData = doctorDoc.data() as Map<String, dynamic>;
            if (!doctorData['clientsId'].contains(receiverId)) {
              {
                await FirebaseFirestore.instance
                    .collection('doctors')
                    .doc(receiverId)
                    .update({
                      'clientsId': FieldValue.arrayUnion([currentUserID]),
                    });
              }
            }
          }
         await sendNotification(title: name, body: message, receiverId: receiverId, imageUrl: 1);
        })
        .catchError((error) {
          print('Error sending message: $error');
        });
  }
}
