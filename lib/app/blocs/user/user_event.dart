part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserChanged extends UserEvent {
  UserChanged(this.user);

  final User user;
  @override
  List<Object> get props => [user];
}

class SetUser extends UserEvent {
  SetUser(this.userModel, this.disease, this.diseaseSeverity);

  final UserModel userModel;
  final String disease;
  final int diseaseSeverity;
  @override
  List<Object> get props => [userModel];
}
