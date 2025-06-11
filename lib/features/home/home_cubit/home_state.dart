part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class ImageLoading extends HomeState {}
class ImageLoaded extends HomeState {
}
class ImageFailure extends HomeState {
  final String errMessage;

  ImageFailure({required this.errMessage});
}
class ChangeBottomNavState extends HomeState {}