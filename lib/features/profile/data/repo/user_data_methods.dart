import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';

abstract class UserDataMethods {
  static UserModel userModel = UserModel(
    name: '',
    specialty: '',
    email: '',
    about: '',
    uId: '',
    image: 3,
    clientsId: [],
    rates: [],
    rating: '0.0',
  );
  static Future<UserModel> getData() async {
    final userDoc =
        await FirebaseFirestore.instance
            .collection('doctors')
            .doc(ConstantVariables.uId)
            .get();

    // Check if the document has data
    if (userDoc.data() != null) {
      return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
    } else {
      return userModel;
    }
  }

  static Future<void> updateData({
    required String uId,
    String? name,
    String? about,
    String? specialty,
    int? image,
  }) async {
    // Prepare the map with only the fields that are not null
    Map<String, dynamic> updatedFields = {};

    if (name != null) updatedFields['name'] = name;
    if (about != null) updatedFields['about'] = about;
    if (specialty != null) updatedFields['specialty'] = specialty;
    if (image != null) updatedFields['image'] = image;

    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(uId)
        .update(updatedFields);
  }
}
