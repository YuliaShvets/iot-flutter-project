import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_flutter_project/bloc/user/profile_events.dart';
import 'package:iot_flutter_project/bloc/user/profile_states.dart';
import 'package:path/path.dart';

import '../../repository/local_storage_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LocalStorageRepository localStorageRepository;

  ProfileBloc({required this.localStorageRepository})
      : super(ProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<CheckConnectivity>(_onCheckConnectivity);
    on<LogoutUser>(_onLogoutUser);

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      add(CheckConnectivity());
    });
  }

  Future<void> _onLoadUserProfile(
    LoadUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());
      final userInfo = await localStorageRepository.getUserInfo();
      emit(ProfileLoaded(userInfo: userInfo));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onCheckConnectivity(
    CheckConnectivity event,
    Emitter<ProfileState> emit,
  ) async {
    final result = await Connectivity().checkConnectivity();
    emit(ConnectivityUpdated(result != ConnectivityResult.none));
  }

  void _onLogoutUser(LogoutUser event, Emitter<ProfileState> emit) {
    Navigator.pushNamedAndRemoveUntil(
        context as BuildContext, '/login', (route) => false);
  }
}
