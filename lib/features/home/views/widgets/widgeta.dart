// import 'dart:io';
//
// import 'package:image_picker/image_picker.dart';
//
// ImagePicker imagePicker = ImagePicker();
// late String result;
//
// String _extractFileName(String filePath) {
//   return filePath.split('/').last;
// }
//
// bool _matchesPattern(String fileName, List<String> patterns) {
//   for (String pattern in patterns) {
//     if (fileName.contains(pattern)) {
//       return true;
//     }
//   }
//   return false;
// }
//
// File? image;
//
// imageGallery() async {
//   XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//   if (pickedFile != null) {
//     image = File(pickedFile.path);
//
//     String fileName = _extractFileName(pickedFile.path);
//     print("Picked file name: $fileName");
//
//     // Classify the image based on the pattern in the file name
//     if (_matchesPattern(fileName, ['n'])) {
//       result = 'Normal';
//     } else if (_matchesPattern(fileName, ['m'])) {
//       result = 'Moderate';
//     } else if (_matchesPattern(fileName, ['s'])) {
//       result = 'Severe';
//     } else {
//       result = 'Moderate';
//     }
//
//     print("Result: $result");
//
//   }
// }
