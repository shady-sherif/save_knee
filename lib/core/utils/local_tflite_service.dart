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
    final rawImage = img.decodeImage(imageBytes);
    if (rawImage == null) throw Exception('Failed to decode image');

    final resizedImage = img.copyResize(rawImage, width: inputSize, height: inputSize);
    final input = _imageToNormalizedFloat32(resizedImage);

    final outputShape = _interpreter.getOutputTensor(0).shape;
    final output = List.filled(
      outputShape.reduce((a, b) => a * b),
      0.0,
    ).reshape(outputShape);

    _interpreter.run(input, output);

    final scores = (output[0] as List).cast<double>();
    final predictedIndex = scores.indexWhere(
          (e) => e == scores.reduce((a, b) => a > b ? a : b),
    );

    final labels = [
      "Normal (KL 0)",
      "Doubtful (KL 1)",
      "Mild (KL 2)",
      "Moderate (KL 3)",
      "Severe (KL 4)",
    ];
    return labels[predictedIndex];
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
