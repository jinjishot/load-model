import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

Future<void> main() async {
  // var input = [
  //   [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
  // ];
  // var output = List.filled(1 * 2, 0).reshape([1, 1, 17, 3]);
  // final Interpreter interpreter; //final or late
  // interpreter = await Interpreter.fromAsset(
  //     'lite-model_movenet_singlepose_lightning_3.tflite');
  // interpreter.run(input, output);
}

class poseEstimation {
  void loadModel() async {
    final tfl.Interpreter interpreter;
    interpreter = await tfl.Interpreter.fromAsset(
        'lite-model_movenet_singlepose_lightning_3.tflite');
    interpreter.allocateTensors();
  }
}
