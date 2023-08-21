// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/modules/add_property_screen/cubit/add_property_cubit.dart';
import 'package:untitled/shared/functions/custom_dialog.dart';
import 'dart:async';
import '../../shared/models/property_model.dart';

class GoogleMapView extends StatelessWidget {
  static const route = 'GoogleMapView';
  final bool select;
  final AddPropertyCubit? addPropertyCubit;
  var lat;
  var lon;
  List<PropertyModel> locations = [];
  GoogleMapView({
    super.key,
    required this.select,
    required this.locations,
    this.addPropertyCubit,
    this.lat,
    this.lon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Property Location'),
      ),
      body: GoogleMapViewBody(
        locations: locations,
        select: select,
        addPropertyCubit: addPropertyCubit,
        lat: lat,
        lon: lon,
      ),
    );
  }
}

class GoogleMapViewBody extends StatefulWidget {
  final bool select;
  final AddPropertyCubit? addPropertyCubit;
  var lat;
  var lon;
  List<PropertyModel> locations = [];

  GoogleMapViewBody({
    super.key,
    required this.select,
    required this.locations,
    this.addPropertyCubit,
    this.lat,
    this.lon,
  });

  @override
  State<GoogleMapViewBody> createState() => _GoogleMapViewBodyState();
}

class _GoogleMapViewBodyState extends State<GoogleMapViewBody> {
  Position? cl;
  CameraPosition? _kGooglePlex;
  Set<Marker> _markers = {};
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;

  Map<String, dynamic> location = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future getPosition() async {
    bool services;
    LocationPermission permeation;

    services = await Geolocator.isLocationServiceEnabled();
    log(services.toString());
    if (services == false) {
      // do any thing if you wont;
    }

    permeation = await Geolocator.checkPermission();
    if (permeation == LocationPermission.denied) {
      permeation = await Geolocator.requestPermission();
    }
    log(permeation.toString());
  }

  Future<void> getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    widget.lat = cl!.latitude;
    widget.lon = cl!.longitude;
    location['lat'] = widget.lat;
    location['long'] = widget.lon;
    // _markers.clear();
    _markers.add(Marker(
      markerId: const MarkerId('1'),
      position: LatLng(cl!.latitude, cl!.longitude),
      icon: customMarker,
    ));

    _kGooglePlex = CameraPosition(
      target: LatLng(cl!.latitude, cl!.longitude),
      zoom: 16.4746,
    );
    setState(() {});
  }

  void addLocationsToMarker() async {
    _markers.clear();
    for (var element in widget.locations) {
      _markers.add(
        Marker(
            markerId: MarkerId(element.id.toString()),
            position: LatLng(element.x, element.y),
            icon: element.id == -1
                ? await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration.empty,
                    'assets/images/location.png',
                  )
                : await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration.empty,
                    'assets/images/home1.png',
                  ),
            onTap: () {
              if (element.id != -1) {
                CustomDialog.detailsDialog(context, element: element);
              }
            }),
      );
    }
    log(_markers.toString());
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.locations[0].x, widget.locations[0].y),
      zoom: 13.7,
    );
  }

  getCustomMArker() async {
    log('xxxxxxxxxxxxxxxxxxxxxxxxx');
    customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/home1.png',
    );
    setState(() {});
  }

  @override
  void initState() {
    getCustomMArker();
    if (widget.lat == null && widget.lon == null && widget.locations.isEmpty) {
      getPosition();
      getLatAndLong();
    }

    if (widget.locations.isNotEmpty) {
      addLocationsToMarker();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lat != null && widget.lon != null) {
      _markers.clear();
      _markers = {
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(widget.lat, widget.lon),
          icon: customMarker,
        ),
      };
      _kGooglePlex = CameraPosition(
        target: LatLng(widget.lat, widget.lon),
        zoom: 16.4746,
      );
      // setState(() {});
    }

    Set<Circle> circles = widget.locations.isNotEmpty
        ? {
            Circle(
              circleId: const CircleId('1'),
              center: LatLng(widget.locations[0].x, widget.locations[0].y),
              radius: 2500,
              fillColor: Colors.blue.withOpacity(.099),
              strokeWidth: 2,
              strokeColor: Colors.blue,
              visible: !widget.select,
            )
          }
        : {};
    return Column(
      children: [
        if (_kGooglePlex == null ||
            _markers.isEmpty ||
            customMarker == BitmapDescriptor.defaultMarker)
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onTap: (val) {
                    if (widget.select == true) {
                      widget.lat = val.latitude;
                      location['lat'] = widget.lat;

                      widget.lon = val.longitude;
                      location['long'] = widget.lon;

                      setState(
                        () {
                          _markers.clear();
                          _markers.add(Marker(
                              markerId: const MarkerId('1'),
                              position: LatLng(widget.lat!, widget.lon!),
                              onTap: () {},
                              draggable: true));
                        },
                      );
                    }
                    // }
                  },
                  mapType: MapType.normal,
                  markers: _markers,
                  initialCameraPosition: _kGooglePlex as CameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  circles: circles,
                ),
                if (widget.locations.isEmpty && widget.select == true)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 55.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(300),
                        color: Colors.grey,
                      ),
                      margin: const EdgeInsets.all(20),
                      child: TextButton(
                        onPressed: () async {
                          widget.lat = null;
                          widget.lon = null;
                          getPosition();
                          getLatAndLong();
                          // CameraPosition cameraPosition = CameraPosition(
                          //   target: LatLng(widget.lat, widget.lon),
                          //   zoom: 14,
                          // );
                          final GoogleMapController googleMapController =
                              await _controller.future;
                          googleMapController.animateCamera(
                            CameraUpdate.newLatLngZoom(
                                LatLng(widget.lat, widget.lon), 14),
                          );
                        },
                        child: const Icon(
                          Icons.location_searching_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        if (widget.select == true)
          Container(
            padding: const EdgeInsets.all(6),
            width: double.infinity,
            child: ElevatedButton(
              //  style: ButtonStyle(alignment: Alignment.),
              child: const Text(
                'Save Location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                if (widget.addPropertyCubit != null) {
                  widget.addPropertyCubit!.x = widget.lat;
                  widget.addPropertyCubit!.y = widget.lon;
                }

                log(location.toString());
                log(widget.lat.toString());
                log(widget.lon.toString());
                Navigator.pop(context, location);
              },
            ),
          ),
      ],
    );
  }
}
