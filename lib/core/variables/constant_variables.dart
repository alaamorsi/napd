import 'package:nabd/core/images/constant_images.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';

abstract class ConstantVariables {
  static String uId = '';
  static String guestuId = '';
  static UserModel? userData;
  static List<String> profileimagesList = [
    ConstantImages.ad1,
    ConstantImages.ad2,
    ConstantImages.ad3,
  ];
}
