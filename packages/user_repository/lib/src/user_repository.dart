import 'package:image_picker/image_picker.dart';
import 'package:user_repository/src/models/user.dart';

abstract class UserRepository {
  Future<void> setUser(User user);
  Stream<User> userStream(String uid);
  Future<String> uploadImageAndGetLink(String uid, XFile xFile);
}
