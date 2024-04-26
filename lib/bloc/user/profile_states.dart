abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, String> userInfo;
  final bool isConnected;
  ProfileLoaded({required this.userInfo, this.isConnected = true});
}

class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);
}

class ConnectivityUpdated extends ProfileState {
  final bool isConnected;
  ConnectivityUpdated(this.isConnected);
}
