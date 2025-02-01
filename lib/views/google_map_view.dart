import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:route_tracker/utils/location_service.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initalCameraPoistion;
  Location location = Location();
  late GoogleMapController googleMapController;
  @override
  void initState() {
    initalCameraPoistion = const CameraPosition(target: LatLng(0, 0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: initalCameraPoistion,
      onMapCreated: (controller) {
        googleMapController = controller;
        updateCurrentLocationData();
      },
    );
  }

  void updateCurrentLocationData() async {
    try {
      var locationData = await location.getLocation();
      CameraPosition myCurrentLocationData = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 16,
      );
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(myCurrentLocationData));
    } on LocationServiceException catch (e) {
      // TODO
    } on LocationPermissionException catch (e) {
      // TODO
    } catch (e) {
      // TODO
    }
  }
}
