part of 'auth_cubit.dart';

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class GetUserSuccess extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthFailure extends AuthState {
  final String errMessage;
  AuthFailure({required this.errMessage});

}
class ImageInitial extends AuthState {}
class ImageLoading extends AuthState {}

class ImageLoaded extends AuthState {
}
class LoginSuccess extends AuthState {}
class LoginLoading extends AuthState {}
class LoginFailure extends AuthState {
  final String errMessage;
  LoginFailure({required this.errMessage});
}
class ImageFailure extends AuthState {
  final String errMessage;

  ImageFailure({required this.errMessage});
}
class DoctorsListLoaded extends AuthState {}