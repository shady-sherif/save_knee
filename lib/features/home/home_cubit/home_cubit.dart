import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_knee_23/features/home/views/widgets/home_view_body.dart';

import '../views/chat_list_view.dart';
import '../views/widgets/ray_test.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  // CollectionReference userCollection =
  //     FirebaseFirestore.instance.collection('users');
  // final storage = FirebaseStorage.instance;
  //  UserModel? userModel;
  //
  // Future<void> uploadImages(File imageFile) async {
  //   emit(HomeInitial());
  //   try {
  //     final Reference storageRef = storage.ref().child('users');
  //     final UploadTask uploadTask =
  //         storageRef.child('${imageFile.hashCode}').putFile(imageFile);
  //     final TaskSnapshot snapshot = await uploadTask;
  //     final String downloadUrl = await snapshot.ref.getDownloadURL();
  //     final uId = FirebaseAuth.instance.currentUser!.uid;
  //     await userCollection.doc(uId).update({'profileImage': downloadUrl});
  //     await getUser();
  //     emit(ImageLoaded());
  //   } catch (e) {
  //     emit(ImageFailure(errMessage: e.toString()));
  //   }
  // }
  //
  // Future<void> getUser() async {
  //   final uId = FirebaseAuth.instance.currentUser!.uid;
  //   final docSnapshot = await userCollection.doc(uId).get();
  //   userModel = UserModel.fromJson(docSnapshot);
  // }
  List<Widget> screens = [
    const HomeViewBody(),
     const XRayScreenT(),
    const ChatListView(),
  ];
  int currentIndex = 0;

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
}
