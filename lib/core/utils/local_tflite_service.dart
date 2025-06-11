import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class KneeOAClassifier {
  late final Interpreter _interpreter;
  final int inputSize = 224;

  Future<void> loadModel() async {
    _interpreter =
        await Interpreter.fromAsset("assets/models/finalmodel2024.tflite");
  }

  Future<String> predict(Uint8List imageBytes) async {
    // Decode and resize image
    final rawImage = img.decodeImage(imageBytes);
    if (rawImage == null) throw Exception('Failed to decode image');

    final resizedImage =
        img.copyResize(rawImage, width: inputSize, height: inputSize);

    // Preprocess image to float32 input
    final input = _imageToNormalizedFloat32(resizedImage);

    // Prepare output buffer (e.g. 1x5 output tensor for 5-class classification)
    final output = List.filled(5, 0.0).reshape([1, 5]);

    // Run inference
    _interpreter.run(input, output);

    // Get predicted class index
    final scores = output[0];
    final predictedIndex =
        scores.indexWhere((e) => e == scores.reduce((a, b) => a > b ? a : b));

    return predictedIndex.toString();
  }

  /// Convert image to [1, height, width, 3] float32 normalized format
  List<List<List<List<double>>>> _imageToNormalizedFloat32(img.Image image) {
    return [
      List.generate(
        inputSize,
            (y) => List.generate(inputSize, (x) {
          final pixel = image.getPixel(x, y);
          return [
            pixel.r / 255.0,
            pixel.g / 255.0,
            pixel.b / 255.0,
          ];
        }),
      )
    ];
  }
}
