import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smartie/verification_id_back.dart';

class IDScannerScreen extends StatefulWidget {
  final String verifyIdType;
  const IDScannerScreen({super.key, required this.verifyIdType});
  @override
  _IDScannerScreenState createState() => _IDScannerScreenState();
}

class _IDScannerScreenState extends State<IDScannerScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;
  File? _image;
  bool _isProcessing = false;
  bool _camerasLoaded = false; // Added this
  double screenWidth = 100;
  double screenHeight = 100;
  String idType = "";

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    print("IDScannerScreen: Starting camera setup");
    print(widget.verifyIdType);
    idType = widget.verifyIdType.toString();
    try {
      _cameras = await availableCameras();
      print("IDScannerScreen: Available cameras found");
      _cameraController = CameraController(
        _cameras.first,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _cameraController.initialize();
      _initializeControllerFuture.then((_) {
        print("IDScannerScreen: Camera initialized");
        setState(() {
          print("IDScannerScreen: setState called");
        });
      });
      setState(() {
        _camerasLoaded = true; // Added this
      });
    } catch (e) {
      print("IDScannerScreen: Error getting available cameras: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _cameraController.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${DateTime.now()}.jpg';
      await File(image.path).copy(imagePath);
      setState(() {
        _image = File(imagePath);
      });
    } catch (e) {
      print("IDScannerScreen: Error taking picture: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
      Navigator.pop(context);
    }
  }

  Future<void> _sendImageToApi(File imageFile, BuildContext context) async {
    setState(() {
      _isProcessing = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationIdBackPage(idType: idType),
      ),
    );
    setState(() {
      _isProcessing = false;
      _image = null;
    });
    return;
    // try {
    //   Uint8List imageBytes = await imageFile.readAsBytes();
    //   String base64Image = base64Encode(imageBytes);

    //   var response = await http.post(
    //     Uri.parse(
    //       'https://mic.thegwd.ca/test/api/uploadphoto',
    //     ), // Replace with your API endpoint
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode({'ImageData': base64Image}),
    //   );

    //   if (response.statusCode == 200) {
    //     print(response.statusCode);
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const VerificationIdBackPage(),
    //       ),
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('API Error: ${response.statusCode}')),
    //     );
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const VerificationIdBackPage(),
    //       ),
    //     );
    //   }
    // } catch (e) {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(SnackBar(content: Text('Error: $e')));
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const VerificationIdBackPage()),
    //   );
    // } finally {
    //   setState(() {
    //     _isProcessing = false;
    //     _image = null;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    print("IDScannerScreen: build called");
    return Scaffold(
      appBar: AppBar(title: Text('Scan Front of ID')),
      body:
          _camerasLoaded
              ? FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  print(
                    "IDScannerScreen: FutureBuilder snapshot: ${snapshot.connectionState}",
                  );
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (!_cameraController.value.isInitialized) {
                      print("IDScannerScreen: Camera not initialized");
                      return Center(child: CircularProgressIndicator());
                    }
                    print("IDScannerScreen: Camera preview ready");
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CameraPreview(_cameraController),
                        _buildOverlay(),
                        if (_image == null)
                          (Container(
                            width: 300,
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.only(
                              top: 50,
                              bottom: screenHeight - 200,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                "Please make sure your ID fills the shape below and is not blurry",
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                        if (_image != null)
                          Stack(
                            children: [
                              Positioned.fill(
                                child: Image.file(_image!, fit: BoxFit.cover),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                    top: 5.0,
                                  ),
                                  height: 100,
                                  width: screenWidth,
                                  color: Colors.white,
                                  child: Text(
                                    "Are you happy with this picture?",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                    });
                                  },
                                  child: Text(
                                    "Retake",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                        0,
                                        162,
                                        233,
                                        1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        Positioned(
                          bottom: _image != null ? 10 : 20,
                          left: _image != null ? 45 : null,
                          child:
                              _isProcessing
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                        0,
                                        162,
                                        233,
                                        1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    onPressed:
                                        _image != null
                                            ? () => _sendImageToApi(
                                              _image!,
                                              context,
                                            )
                                            : _takePicture,
                                    child: Text(
                                      style: TextStyle(color: Colors.white),
                                      _image == null ? 'Take Picture' : 'Yes',
                                    ),
                                  ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
              : Center(
                child: CircularProgressIndicator(),
              ), // Show loading while cameras load
    );
  }

  Widget _buildOverlay() {
    final screenWidth = MediaQuery.of(context).size.width;
    final overlaySize = screenWidth * 0.8;

    return IgnorePointer(
      child: Center(
        child: Container(
          width: overlaySize * 0.6,
          height: overlaySize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
