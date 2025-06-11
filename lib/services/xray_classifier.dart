
// loadModelFiles() async {
//   String? res = await Tflite.loadModel(
//     // model file
//     model: "assets/model/finalmodel2024.tflite",
//     // labels file
//     labels: "assets/model/labels.txt",
//     // defaults to 1
//     numThreads: 1,
//     // defaults to true, set to false to load resources outside assets
//     isAsset: true,
//     // defaults to false, set to true to use GPU delegate
//     useGpuDelegate: false,
//   );
//
//   //for testing and debugging
//   print(res);
// }

// Future<String> doImageClassification(File? image) async {
//   String result = '';
//   var recognitions = await Tflite.runModelOnImage(
//
//     path: image!.path,
//
//     imageMean: 0.0,
//
//     imageStd: 255.0,
//
//     numResults: 2,
//
//     threshold: 0.1,
//
//     asynch: true,
//   );
//
//   //for testing and debugging
//   print(recognitions!.length.toString());
//
//   //update result string
//   for (var recog in recognitions) {
//     //for testing and debugging
//     print(recog.toString());
//
//     String label = recog["label"];
//     double conf = recog["confidence"] as double;
//     conf = conf * 100;
//
//     result += '$label with confidence of ${conf.toStringAsPrecision(2)} %\n';
//   }
//   return result;
// }
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<String> classifyImage(File image) async {
//   var request = http.MultipartRequest(
//     'POST',
//     Uri.parse('http://127.0.0.1:5000/classify'),
//   );

//   request.files.add(await http.MultipartFile.fromPath('image', image.path));

//   var response = await request.send();

//   if (response.statusCode == 200) {
//     var responseBody = await response.stream.bytesToString();
//     var jsonResponse = json.decode(responseBody);
//     String result = '';
//     for (var item in jsonResponse) {
//       result += '${item['label']} with confidence of ${(item['confidence'] * 100).toStringAsPrecision(2)} %\n';
//     }
//     return result;
//   } else {
//     return 'Error: ${response.statusCode}';
//   }
// }