import 'package:flutter/foundation.dart';
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

    final resizedImage =
        img.copyResize(rawImage, width: inputSize, height: inputSize);
    final input = _imageToNormalizedFloat32(resizedImage);

    final outputShape = _interpreter.getOutputTensor(0).shape;
    final output = List.filled(
      outputShape.reduce((a, b) => a * b),
      0.0,
    ).reshape(outputShape);

    _interpreter.run(input, output);

    final scores = (output.last as List).cast<double>();

    // Debug: debugPrint all scores to see what the model is actually outputting
    debugPrint("Model output scores: $scores");

    // Find the index with the highest probability (using proper argmax)
    int predictedIndex = 0;
    double maxScore = scores[0];
    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > maxScore) {
        maxScore = scores[i];
        predictedIndex = i;
      }
    }

    debugPrint("Predicted index: $predictedIndex, confidence: $maxScore");

    final labels = [
      "Normal (KL 0)",
      "Doubtful (KL 1)",
      "Mild (KL 2)",
      "Moderate (KL 3)",
      "Severe (KL 4)",
    ];

    // Add bounds checking
    if (predictedIndex >= labels.length) {
      throw Exception(
          'Predicted index $predictedIndex is out of bounds for labels');
    }

    debugModelInfo();

    return "${labels[predictedIndex]} (confidence: ${(maxScore * 100).toStringAsFixed(1)}%)";
  }

  /// Convert image to [1, height, width, 3] float32 normalized format
  List<List<List<List<double>>>> _imageToNormalizedFloat32(img.Image image) {
    // Ensure we're working with RGB format
    final rgbImage = image.convert(numChannels: 3);

    return [
      List.generate(
        inputSize,
        (y) => List.generate(inputSize, (x) {
          final pixel = rgbImage.getPixel(x, y);

          // Alternative normalization approaches - try these if current doesn't work:

          // Option 1: Standard 0-1 normalization (current)
          return [
            pixel.r / 255.0,
            pixel.g / 255.0,
            pixel.b / 255.0,
          ];

          // Option 2: ImageNet normalization (uncomment if needed)
          // return [
          //   (pixel.r / 255.0 - 0.485) / 0.229,
          //   (pixel.g / 255.0 - 0.456) / 0.224,
          //   (pixel.b / 255.0 - 0.406) / 0.225,
          // ];

          // Option 3: [-1, 1] normalization (uncomment if needed)
          // return [
          //   (pixel.r / 255.0) * 2.0 - 1.0,
          //   (pixel.g / 255.0) * 2.0 - 1.0,
          //   (pixel.b / 255.0) * 2.0 - 1.0,
          // ];
        }),
      )
    ];
  }

  // Additional debugging method
  Future<void> debugModelInfo() async {
    debugPrint("Input tensor info:");
    final inputTensor = _interpreter.getInputTensor(0);
    debugPrint("  Shape: ${inputTensor.shape}");
    debugPrint("  Type: ${inputTensor.type}");

    debugPrint("Output tensor info:");
    final outputTensor = _interpreter.getOutputTensor(0);
    debugPrint("  Shape: ${outputTensor.shape}");
    debugPrint("  Type: ${outputTensor.type}");
  }
}
