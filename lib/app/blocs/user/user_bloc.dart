import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late final StreamSubscription<User> _userSubscription;
  UserRepository userRepository = FirebaseUserRepository();
  final String uid;
  UserBloc(this.uid)
      : super(
          UserState(
            user: User.empty,
            isLoading: true,
            error: "",
          ),
        ) {
    on<UserChanged>(_onUserChanged);
    on<SetUser>(_onSetUser);
    _userSubscription = userRepository.userStream(uid).listen(
          (user) => add(UserChanged(user)),
        );
  }

  FutureOr<void> _onUserChanged(
    UserChanged event,
    Emitter<UserState> emit,
  ) {
    emit(
      state.copyWith(
        isLoading: false,
        error: "",
        user: event.user,
      ),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onSetUser(SetUser event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: ""));
    try {
      await userRepository.setUser(
        User(
          id: event.userModel.id,
          displayName: event.userModel.name ?? "",
          email: event.userModel.email ?? "",
          photoURL: event.userModel.photo ?? "",
          phoneNumber: event.userModel.mobile ?? "",
          uid: event.userModel.id,
          timestamp: Timestamp.now(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
    emit(state.copyWith(isLoading: false));
  }
}
