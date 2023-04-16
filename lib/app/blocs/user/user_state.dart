part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    required this.user,
    required this.isLoading,
    required this.error,
  });
  final User user;
  final bool isLoading;
  final String error;

  UserState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        user,
        isLoading,
        error,
      ];
}
