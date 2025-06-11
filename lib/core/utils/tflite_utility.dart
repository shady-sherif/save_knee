// import 'dart:io';
// import 'package:tflite/tflite.dart';
//
// // Class to handle TensorFlow Lite model loading and inference
// class TFLiteModelHandler {
//   final String modelPath;
//   final String labelsPath;
//   final double imageMean;
//   final double imageStd;
//   final int numResults;
//   final double threshold;
//
//   TFLiteModelHandler({
//     required this.modelPath,
//     required this.labelsPath,
//     this.imageMean = 0.0,
//     this.imageStd = 255.0,
//     this.numResults = 2,
//     this.threshold = 0.2,
//   });
//
//   // Initialize the model
//   Future<void> initModel() async {
//     try {
//       await Tflite.loadModel(
//         model: modelPath,
//         labels: labelsPath,
//       );
//     } catch (e) {
//       throw Exception('Failed to load model: $e');
//     }
//   }
//
//   // Run inference on an image file
//   Future<List<dynamic>?> runInference(File image) async {
//     try {
//       return await Tflite.runModelOnImage(
//         path: image.path,
//         imageMean: imageMean,
//         imageStd: imageStd,
//         numResults: numResults,
//         threshold: threshold,
//       );
//     } catch (e) {
//       throw Exception('Inference failed: $e');
//     }
//   }
//
//   // Clean up resources
//   void dispose() {
//     Tflite.close();
//   }
// }