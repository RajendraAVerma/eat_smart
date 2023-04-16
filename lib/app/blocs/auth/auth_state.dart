part of 'auth_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
  loading,
}

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user = UserModel.empty,
  });

  const AuthState.authenticated(UserModel user)
      : this._(status: AppStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this._(status: AppStatus.unauthenticated);
  const AuthState.loading() : this._(status: AppStatus.loading);

  final AppStatus status;
  final UserModel user;

  @override
  List<Object> get props => [status, user];
}
