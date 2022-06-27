import 'dart:async';
import 'dart:ui' as ui show Image;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spritewidget/spritewidget.dart';

late ImageMap _images;
late SpriteSheet _sprites;

enum WeatherType { sun, rain, snow }

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

const LatLng _kMapCenter = LatLng(40.7128, -74.0060);

class _MapsScreenState extends State<MapsScreen> {
  GoogleMapController? mapController;
  BitmapDescriptor? _markerIcon;
  bool assetsLoaded = false;

  // The weather world is our sprite tree that handles the weather
  // animations.
  late WeatherWorld weatherWorld = WeatherWorld();
  // The image map hold all of our image assets.

// The sprite sheet contains an image and a set of rectangles defining the
// individual sprites.

  // ignore: use_setters_to_change_properties
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

// This method loads all assets that are needed for the demo.
  Future<void> _loadAssets(AssetBundle bundle) async {
    // Load images using an ImageMap
    _images = ImageMap();
    await _images.load(<String>[
      'assets/images/clouds-0.png',
      'assets/images/clouds-1.png',
      'assets/images/ray.png',
      'assets/images/sun.png',
      'assets/images/night.png',
      'assets/images/autumn.png',
      'assets/images/spring.gif',
      'assets/images/weathersprites.png',
    ]);

    // Load the sprite sheet, which contains snowflakes and rain drops.
    String json = await DefaultAssetBundle.of(context)
        .loadString('assets/weathersprites-A.json');
    _sprites = SpriteSheet(
      image: _images['assets/images/autumn.png']!,
      jsonDefinition: json,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(milliseconds: 300),
      () {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                bearing: 270.0,
                target: LatLng(40.7128, -74.0060),
                tilt: 30.0,
                zoom: 17.0,
              ),
            ),
          );
        });
      },
    );
    // Get our root asset bundle
    AssetBundle bundle = rootBundle;

    // Load all graphics, then set the state to assetsLoaded and create the
    // WeatherWorld sprite tree
    _loadAssets(bundle).then((_) {
      setState(() {
        assetsLoaded = true;
        weatherWorld = WeatherWorld();
        weatherWorld.weatherType = WeatherType.snow;
      });
    });
  }

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _kMapCenter,
        icon: _markerIcon!,
      );
    } else {
      return const Marker(
        markerId: MarkerId('marker_1'),
        position: _kMapCenter,
      );
    }
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size.square(95));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/images/pin.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return Material(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: Text(""),
            ),
          ],
          leading: BackButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: <Marker>{_createMarker()},
                  initialCameraPosition:
                      const CameraPosition(target: LatLng(0.0, 0.0)),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: Opacity(
                opacity: 0.5,
                child: true
                    ? SpriteWidget(
                        weatherWorld,
                      )
                    : Image.asset(
                        "assets/images/night.png",
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 300),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       Column(
            //         children: <Widget>[
            //           TextButton(
            //             onPressed: () {
            //               mapController?.animateCamera(
            //                 CameraUpdate.newCameraPosition(
            //                   const CameraPosition(
            //                     bearing: 270.0,
            //                     target: LatLng(51.5160895, -0.1294527),
            //                     tilt: 30.0,
            //                     zoom: 17.0,
            //                   ),
            //                 ),
            //               );
            //             },
            //             child: const Text('newCameraPosition'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               mapController?.animateCamera(
            //                 CameraUpdate.newLatLng(
            //                   const LatLng(56.1725505, 10.1850512),
            //                 ),
            //               );
            //             },
            //             child: const Text('newLatLng'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               mapController?.animateCamera(
            //                 CameraUpdate.newLatLngBounds(
            //                   LatLngBounds(
            //                     southwest: const LatLng(-38.483935, 113.248673),
            //                     northeast: const LatLng(-8.982446, 153.823821),
            //                   ),
            //                   10.0,
            //                 ),
            //               );
            //             },
            //             child: const Text('newLatLngBounds'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               mapController?.animateCamera(
            //                 CameraUpdate.newLatLngZoom(
            //                   const LatLng(37.4231613, -122.087159),
            //                   11.0,
            //                 ),
            //               );
            //             },
            //             child: const Text('newLatLngZoom'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               mapController?.animateCamera(
            //                 CameraUpdate.scrollBy(150.0, -225.0),
            //               );
            //             },
            //             child: const Text('scrollBy'),
            //           ),
            //         ],
            //       ),
            //       Column(
            //         children: <Widget>[
            //           TextButton(
            //             onPressed: () {
            //               mapController?.animateCamera(
            //                 CameraUpdate.zoomBy(
            //                   -0.5,
            //                   const Offset(30.0, 20.0),
            //                 ),
            //               );
            //             },
            //             child: const Text('zoomBy with focus'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               mapController?.animateCamera(
            //                 CameraUpdate.zoomBy(-0.5),
            //               );
            //             },
            //             child: const Text('zoomBy'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               mapController?.animateCamera(
            //                 CameraUpdate.zoomIn(),
            //               );
            //             },
            //             child: const Text('zoomIn'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               mapController?.animateCamera(
            //                 CameraUpdate.zoomOut(),
            //               );
            //             },
            //             child: const Text('zoomOut'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               mapController?.animateCamera(
            //                 CameraUpdate.zoomTo(16.0),
            //               );
            //             },
            //             child: const Text('zoomTo'),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

// For the different weathers we are displaying different gradient backgrounds,
// these are the colors for top and bottom.
const List<Color> _kBackgroundColorsTop = <Color>[
  Color(0xff5ebbd5),
  Color(0xff0b2734),
  Color(0xffcbced7),
];

const List<Color> _kBackgroundColorsBottom = <Color>[
  Color(0xff4aaafb),
  Color(0xff4c5471),
  Color(0xffe0e3ec),
];

// The WeatherWorld is our root node for our sprite tree. The size of the tree
// will be scaled to fit into our SpriteWidget container.
class WeatherWorld extends NodeWithSize {
  WeatherWorld() : super(const Size(2048.0, 2048.0)) {
    // Start by adding a background.
    _background = GradientNode(
      size,
      _kBackgroundColorsTop[0],
      _kBackgroundColorsBottom[0],
    );
    addChild(_background);

    // Then three layers of clouds, that will be scrolled in parallax.
    _cloudsSharp = CloudLayer(
      image: _images['assets/images/clouds-0.png']!,
      rotated: false,
      dark: false,
      loopTime: 20.0,
    );
    addChild(_cloudsSharp);

    _cloudsDark = CloudLayer(
      image: _images['assets/images/clouds-1.png']!,
      rotated: true,
      dark: true,
      loopTime: 40.0,
    );
    addChild(_cloudsDark);

    _cloudsSoft = CloudLayer(
      image: _images['assets/images/clouds-1.png']!,
      rotated: false,
      dark: false,
      loopTime: 60.0,
    );
    addChild(_cloudsSoft);

    // Add the sun, rain, and snow (which we are going to fade in/out depending
    // on which weather are selected.
    _sun = Sun();
    _sun.position = const Offset(1024.0, 1024.0);
    _sun.scale = 1.5;
    addChild(_sun);

    _rain = Rain();
    addChild(_rain);

    _snow = Snow();
    addChild(_snow);
  }

  late GradientNode _background;
  late CloudLayer _cloudsSharp;
  late CloudLayer _cloudsSoft;
  late CloudLayer _cloudsDark;
  late Sun _sun;
  late Rain _rain;
  late Snow _snow;

  WeatherType get weatherType => _weatherType;

  WeatherType _weatherType = WeatherType.sun;

  set weatherType(WeatherType weatherType) {
    if (weatherType == _weatherType) return;

    // Handle changes between weather types.
    _weatherType = weatherType;

    // Fade the background
    _background.motions.stopAll();

    // Fade the background from one gradient to another.
    _background.motions.run(
      MotionTween<Color>(
        setter: (a) => _background.colorTop = a,
        start: _background.colorTop,
        end: _kBackgroundColorsTop[weatherType.index],
        duration: 1.0,
      ),
    );

    _background.motions.run(
      MotionTween<Color>(
        setter: (a) => _background.colorBottom = a,
        start: _background.colorBottom,
        end: _kBackgroundColorsBottom[weatherType.index],
        duration: 1.0,
      ),
    );

    // Activate/deactivate sun, rain, snow, and dark clouds.
    _cloudsDark.active = weatherType != WeatherType.sun;
    _sun.active = weatherType == WeatherType.sun;
    _rain.active = weatherType == WeatherType.rain;
    _snow.active = weatherType == WeatherType.snow;
  }

  @override
  void spriteBoxPerformedLayout() {
    // If the device is rotated or if the size of the SpriteWidget changes we
    // are adjusting the position of the sun.
    _sun.position =
        spriteBox!.visibleArea!.topLeft + const Offset(350.0, 180.0);
  }
}

// The GradientNode performs custom drawing to draw a gradient background.
class GradientNode extends NodeWithSize {
  GradientNode(Size size, this.colorTop, this.colorBottom) : super(size);

  Color colorTop;
  Color colorBottom;

  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);

    Rect rect = Offset.zero & size;
    Paint gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[colorTop, colorBottom],
        stops: const <double>[0.0, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, gradientPaint);
  }
}

// Draws and animates a cloud layer using two sprites.
class CloudLayer extends Node {
  CloudLayer(
      {required ui.Image image,
      required bool dark,
      required bool rotated,
      required double loopTime}) {
    // Creates and positions the two cloud sprites.
    _sprites.add(_createSprite(image, dark, rotated));
    _sprites[0].position = const Offset(1024.0, 1024.0);
    addChild(_sprites[0]);

    _sprites.add(_createSprite(image, dark, rotated));
    _sprites[1].position = const Offset(3072.0, 1024.0);
    addChild(_sprites[1]);

    // Animates the clouds across the screen.
    motions.run(
      MotionRepeatForever(
        motion: MotionTween<Offset>(
          setter: (a) => position = a,
          start: Offset.zero,
          end: const Offset(-2048.0, 0.0),
          duration: loopTime,
        ),
      ),
    );
  }

  final List<Sprite> _sprites = <Sprite>[];

  Sprite _createSprite(ui.Image image, bool dark, bool rotated) {
    Sprite sprite = Sprite.fromImage(image);

    if (rotated) sprite.scaleX = -1.0;

    if (dark) {
      sprite.colorOverlay = const Color(0xff000000);
      sprite.opacity = 0.0;
    }

    return sprite;
  }

  set active(bool active) {
    // Toggle visibility of the cloud layer
    double opacity;
    if (active) {
      opacity = 1.0;
    } else {
      opacity = 0.0;
    }

    for (Sprite sprite in _sprites) {
      sprite.motions.stopAll();
      sprite.motions.run(
        MotionTween<double>(
          setter: (a) => sprite.opacity = a,
          start: sprite.opacity,
          end: opacity,
          duration: 1.0,
        ),
      );
    }
  }
}

const double _kNumSunRays = 50.0;

// Create an animated sun with rays
class Sun extends Node {
  Sun() {
    // Create the sun
    _sun = Sprite.fromImage(_images['assets/images/sun.png']!);
    _sun.scale = 4.0;
    _sun.blendMode = BlendMode.plus;
    addChild(_sun);

    // Create rays
    _rays = <Ray>[];
    for (int i = 0; i < _kNumSunRays; i += 1) {
      Ray ray = Ray();
      addChild(ray);
      _rays.add(ray);
    }
  }

  late Sprite _sun;
  late List<Ray> _rays;

  set active(bool active) {
    // Toggle visibility of the sun

    motions.stopAll();

    double targetOpacity;
    if (!active) {
      targetOpacity = 0.0;
    } else {
      targetOpacity = 1.0;
    }

    motions.run(
      MotionTween<double>(
        setter: (a) => _sun.opacity = a,
        start: _sun.opacity,
        end: targetOpacity,
        duration: 2.0,
      ),
    );

    if (active) {
      for (Ray ray in _rays) {
        motions.run(
          MotionSequence(
            motions: [
              MotionDelay(delay: 1.5),
              MotionTween<double>(
                setter: (a) => ray.opacity = a,
                start: ray.opacity,
                end: ray.maxOpacity,
                duration: 1.5,
              ),
            ],
          ),
        );
      }
    } else {
      for (Ray ray in _rays) {
        motions.run(
          MotionTween<double>(
            setter: (a) => ray.opacity = a,
            start: ray.opacity,
            end: 0.0,
            duration: 0.2,
          ),
        );
      }
    }
  }
}

// An animated sun ray
class Ray extends Sprite {
  late double _rotationSpeed;
  late double maxOpacity;

  Ray() : super.fromImage(_images['assets/images/ray.png']!) {
    pivot = const Offset(0.0, 0.5);
    blendMode = BlendMode.plus;
    rotation = randomDouble() * 360.0;
    maxOpacity = randomDouble() * 0.2;
    opacity = maxOpacity;
    scaleX = 2.5 + randomDouble();
    scaleY = 0.3;
    _rotationSpeed = randomSignedDouble() * 2.0;

    // Scale animation
    double scaleTime = randomSignedDouble() * 2.0 + 4.0;

    motions.run(
      MotionRepeatForever(
        motion: MotionSequence(
          motions: [
            MotionTween<double>(
              setter: (a) => scaleX = a,
              start: scaleX,
              end: scaleX * 0.5,
              duration: scaleTime,
            ),
            MotionTween<double>(
              setter: (a) => scaleX = a,
              start: scaleX * 0.5,
              end: scaleX,
              duration: scaleTime,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    rotation += dt * _rotationSpeed;
  }
}

// Rain layer. Uses three layers of particle systems, to create a parallax
// rain effect.
class Rain extends Node {
  Rain() {
    _addParticles(1.0);
    _addParticles(1.5);
    _addParticles(2.0);
  }

  final List<ParticleSystem> _particles = <ParticleSystem>[];

  void _addParticles(double distance) {
    ParticleSystem particles = ParticleSystem(
      texture: _sprites['raindrop.png']!,
      blendMode: BlendMode.srcATop,
      posVar: const Offset(1300.0, 0.0),
      direction: 90.0,
      directionVar: 0.0,
      speed: 1000.0 / distance,
      speedVar: 100.0 / distance,
      startSize: 1.2 / distance,
      startSizeVar: 0.2 / distance,
      endSize: 1.2 / distance,
      endSizeVar: 0.2 / distance,
      life: 1.5 * distance,
      lifeVar: 1.0 * distance,
    );
    particles.position = const Offset(1024.0, -200.0);
    particles.rotation = 10.0;
    particles.opacity = 0.0;

    _particles.add(particles);
    addChild(particles);
  }

  set active(bool active) {
    motions.stopAll();
    for (ParticleSystem system in _particles) {
      if (active) {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 1.0,
            duration: 2.0,
          ),
        );
      } else {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 0.0,
            duration: 0.5,
          ),
        );
      }
    }
  }
}

// Snow. Uses 9 particle systems to create a parallax effect of snow at
// different distances.
class Snow extends Node {
  Snow() {
    _addParticles(_sprites['flake-0.png']!, 1.0);
    _addParticles(_sprites['flake-1.png']!, 1.0);
    _addParticles(_sprites['flake-2.png']!, 1.0);

    _addParticles(_sprites['flake-3.png']!, 1.5);
    _addParticles(_sprites['flake-4.png']!, 1.5);
    _addParticles(_sprites['flake-5.png']!, 1.5);

    _addParticles(_sprites['flake-6.png']!, 2.0);
    _addParticles(_sprites['flake-7.png']!, 2.0);
    _addParticles(_sprites['flake-8.png']!, 2.0);
  }

  final List<ParticleSystem> _particles = <ParticleSystem>[];

  void _addParticles(SpriteTexture texture, double distance) {
    ParticleSystem particles = ParticleSystem(
      texture: texture,
      blendMode: BlendMode.srcATop,
      posVar: const Offset(1300.0, 0.0),
      direction: 90.0,
      directionVar: 0.0,
      speed: 150.0 / distance,
      speedVar: 50.0 / distance,
      startSize: 1.0 / distance,
      startSizeVar: 0.3 / distance,
      endSize: 1.2 / distance,
      endSizeVar: 0.2 / distance,
      life: 20.0 * distance,
      lifeVar: 10.0 * distance,
      emissionRate: 2.0,
      startRotationVar: 360.0,
      endRotationVar: 360.0,
      radialAccelerationVar: 10.0 / distance,
      tangentialAccelerationVar: 10.0 / distance,
    );
    particles.position = const Offset(1024.0, -50.0);
    particles.opacity = 0.0;

    _particles.add(particles);
    addChild(particles);
  }

  set active(bool active) {
    motions.stopAll();
    for (ParticleSystem system in _particles) {
      if (active) {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 1.0,
            duration: 2.0,
          ),
        );
      } else {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 0.0,
            duration: 0.5,
          ),
        );
      }
    }
  }
}
