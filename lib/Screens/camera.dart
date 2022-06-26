import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'display.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key, required this.cameraDescription, required this.uid})
      : super(key: key);
  final List<CameraDescription> cameraDescription;
  final String? uid;
  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription> cam = [];
  void getCameraDes(List<CameraDescription> camera) {
    cam = camera;
  }

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isflash = false;
  bool iscamerafront = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        CameraController(widget.cameraDescription[0], ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.pop(context);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.deepPurple,
          body: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    Positioned(
                        top: 0, bottom: 0, child: CameraPreview(_controller)),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: IconButton(
                                icon: isflash
                                    ? Icon(
                                        Icons.flash_on,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.flash_off,
                                        color: Colors.white,
                                      ),
                                onPressed: () {
                                  setState(() {
                                    isflash = !isflash;
                                  });
                                  isflash
                                      ? _controller
                                          .setFlashMode(FlashMode.torch)
                                      : _controller.setFlashMode(FlashMode.off);
                                },
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  setState(() {
                                    iscamerafront = !iscamerafront;
                                  });
                                  int camerapos = iscamerafront
                                      ? 1
                                      : 0; // default is back camera so if iscamera front is true it should go to front camera camera[1]
                                  _controller = CameraController(
                                      widget.cameraDescription[camerapos],
                                      ResolutionPreset.medium);
                                  _initializeControllerFuture =
                                      _controller.initialize();
                                },
                                icon: Icon(
                                  Icons.flip_camera_ios_outlined,
                                  color: Colors.white,
                                ))
                          ],
                        ))
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final image = await _controller.takePicture();
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DisplayPictureScreen(
                          imagePath: image.path,
                          uid: widget.uid,
                        )));
              } catch (e) {
                print(e);
              }
            },
            child: Icon(Icons.camera_alt),
          ),
        ),
      ),
    );
  }
}
