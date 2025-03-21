import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:smartie/home_screen.dart';
import 'package:smartie/login_screen.dart';
import 'dart:convert';
import 'package:smartie/verification_submitted_page.dart';

class IDScannerIdBackScreen extends StatefulWidget {
  const IDScannerIdBackScreen({super.key});
  @override
  _IDScannerScreenIdBackState createState() => _IDScannerScreenIdBackState();
}

class _IDScannerScreenIdBackState extends State<IDScannerIdBackScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;
  File? _image;
  bool _isProcessing = false;
  bool _camerasLoaded = false; // Added this

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    print("IDScannerScreen: Starting camera setup");
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
    }
  }

  Future<void> _sendImageToApi(File imageFile, BuildContext context) async {
    setState(() {
      _isProcessing = true;
    });

    try {
      Uint8List imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      var response = await http.post(
        Uri.parse(
          'https://mic.thegwd.ca/test/api/uploadphoto',
        ), // Replace with your API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'ImageData': base64Image}),
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false, // Remove all existing routes
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('API Error: ${response.statusCode}')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } finally {
      setState(() {
        _isProcessing = false;
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("IDScannerScreen: build called");
    return Scaffold(
      appBar: AppBar(title: Text('Scan ID')),
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
                        if (_image != null)
                          Positioned.fill(
                            child: Image.file(_image!, fit: BoxFit.cover),
                          ),
                        Positioned(
                          bottom: 20,
                          child:
                              _isProcessing
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                    onPressed:
                                        _image != null
                                            ? () => _sendImageToApi(
                                              _image!,
                                              context,
                                            )
                                            : _takePicture,
                                    child: Text(
                                      _image != null
                                          ? 'Send Image'
                                          : 'Take Picture',
                                    ),
                                  ),
                        ),
                        if (_image != null)
                          Positioned(
                            top: 20,
                            right: 20,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              icon: Icon(Icons.close),
                              color: Colors.white,
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
