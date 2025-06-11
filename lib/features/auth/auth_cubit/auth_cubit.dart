import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_knee_23/constants.dart';
import 'package:save_knee_23/features/auth/view_models/login_data.dart';
import 'package:save_knee_23/features/home/view_models/user_model.dart';
import '../view_models/register_data.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  CollectionReference videosCollection =
      FirebaseFirestore.instance.collection('videos');
  CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection(kDoctorsCollection);
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final storage = FirebaseStorage.instance;
  bool? isLoading = false;
  late UserModel userModel;
  List<UserModel> doctorsList = [];

  Future<void> userRegister(RegisterData registerData) async {
    emit(AuthLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: registerData.email, password: registerData.password);
      final uId = userCredential.user!.uid;
      final userModel = UserModel(name: registerData.name, uId: uId);
      await userCollection.doc(uId).set(userModel.toJson());
      await getUser();
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailure(errMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailure(errMessage: 'email already in use'));
      } else {
        emit(AuthFailure(errMessage: 'authentication error'));
      }
    } catch (e) {
      emit(AuthFailure(errMessage: 'something went Wrong'));
    }
  }

  Future<void> userLogin(LoginData loginData) async {
    emit(LoginLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: loginData.email, password: loginData.password);
      final uId = userCredential.user!.uid;
      final docSnapshot = await userCollection.doc(uId).get();
      userModel = UserModel.fromJson(docSnapshot);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'wrong-password'));
      } else {
        emit(LoginFailure(errMessage: 'authentication error'));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'something went wrong'));
    }
  }

  Future<void> uploadImages(File imageFile) async {
    emit(ImageInitial());
    try {
      final Reference storageRef = storage.ref().child('users');
      final UploadTask uploadTask =
          storageRef.child('${imageFile.hashCode}').putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      final uId = FirebaseAuth.instance.currentUser!.uid;
      await userCollection.doc(uId).update({'profileImage': downloadUrl});
      await getUser();
      emit(ImageLoaded());
    } catch (e) {
      emit(ImageFailure(errMessage: e.toString()));
    }
  }

  getDoctorsList() {
    doctorCollection.snapshots().listen((event) {
      doctorsList.clear();
      for (var doc in event.docs) {
        doctorsList.add(UserModel.fromJson(doc));
      }
      emit(DoctorsListLoaded());
    });
  }

  // getVideosList() {
  //   videosCollection.snapshots().listen((event) {
  //     videosList.clear();
  //     for (var doc in event.docs) {
  //       videosList.add(VideoModel.fromJson(doc));
  //     }
  //   });
  // }

    Future<void> getUser() async {
    final uId = FirebaseAuth.instance.currentUser!.uid;
    final docSnapshot = await userCollection.doc(uId).get();
    userModel = UserModel.fromJson(docSnapshot);
  }

  Future<bool> getAuthStatus() async {
    final uId = FirebaseAuth.instance.currentUser!.uid;
    final docSnapshot = await userCollection.doc(uId).get();
    userModel = UserModel.fromJson(docSnapshot);
    bool isUser = FirebaseAuth.instance.currentUser != null;
    getDoctorsList();
    return isUser;
  }
}
