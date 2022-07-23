import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'classifier.dart';
import 'isolate.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const CameraApp());
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  late Classifier classifier;

  @override
  void initState() {
    super.initState();
    setState(() {
      cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    });
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      cameraController!.startImageStream((imageStream) {
        var isolateData =
            IsolateData(imageStream, classifier.interpreter.address);
      });
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController!.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(cameraController!),
    );
  }
}
