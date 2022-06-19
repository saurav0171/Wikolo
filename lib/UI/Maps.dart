import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

const LatLng _kMapCenter = LatLng(40.7128, -74.0060);

class _MapsScreenState extends State<MapsScreen> {
  GoogleMapController? mapController;
  BitmapDescriptor? _markerIcon;
  // ignore: use_setters_to_change_properties
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
