import 'dart:developer';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository myUserRepository})
    : _userRepository = myUserRepository,
      super(const UserState.loading()) {
    on<GetMyUser>((event, emit) async {
      try {
        MyUser myUser = await _userRepository.getMyUser(event.userId);
        emit(UserState.success(myUser));
      } catch (e) {
        log(e.toString());
        emit(UserState.failure());
      }
    });
  }
}
