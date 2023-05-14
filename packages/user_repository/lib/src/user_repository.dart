import 'package:image_picker/image_picker.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:user_repository/src/models/user.dart';

abstract class UserRepository {
  Future<void> setUser(User user);
  Stream<User> userStream(String uid);
  Future<String> uploadImageAndGetLink(String uid, XFile xFile);
  Future<void> consumeFood({
    required String uid,
    required DaywiseLimit daywiseLimit,
    required FoodDetails foodDetails,
  });
  Stream<DaywiseLimit> getDaywiseLimit({
    required String uid,
    required String dayId,
  });
  Stream<List<FoodDetails>> getDayFoodList({
    required String uid,
    required String dayId,
  });
}
