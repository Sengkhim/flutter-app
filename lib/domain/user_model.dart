import '../reposity/dao.dart';
import 'base/identity_model.dart';

class UserModel extends IIdentity<String>
    implements DataAccessObject<UserModel> {
  final String? email;
  final String? username;
  final String? password;
  final String? address;

  UserModel(this.email, this.username, this.password, this.address);

  @override
  String get script => throw UnimplementedError();

  @override
  List<UserModel> fromList(List<Map<String, dynamic>> query) {
    throw UnimplementedError();
  }

  @override
  UserModel fromMap(Map<String, dynamic> query) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap(UserModel object) {
    throw UnimplementedError();
  }
}
