/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/views/common_widgets/AppButton.dart';

class Geofencesample extends StatefulWidget {
  const Geofencesample({super.key});

  @override
  State<Geofencesample> createState() => _GeofencesampleState();
}

class _GeofencesampleState extends State<Geofencesample> {
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  */
/*  _addGeoFence();
    bg.BackgroundGeolocation.onGeofence(_onGeoFence);
    bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 10,
            stopOnTerminate: false,
            startOnBoot: true,
            debug: false,
            logLevel: bg.Config.LOG_LEVEL_OFF))
        .then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.startGeofences();
      }
    });

    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      print("LOCATION >>> $location");
      setState(() {
        _longitudeController.text = location.coords.longitude.toString();
        _latitudeController.text = location.coords.latitude.toString();
      });
    });
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print("LOCATION >>> $location");
      setState(() {
        _longitudeController.text = location.coords.longitude.toString();
        _latitudeController.text = location.coords.latitude.toString();
      });
    });
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print("LOCATION >>> $event");
    });
  *//*


  }

  _addGeoFence() {
    bg.BackgroundGeolocation.addGeofence(bg.Geofence(
            identifier: 'HOME',
            radius: 150,
            latitude: 33.8688,
            longitude: 151.2093,
            notifyOnEntry: true,
            notifyOnExit: true,
            loiteringDelay: 3000))
        .then((bool success) {
      print("SUCCESSFULLY ADDED GEO FENCE");
    }).catchError((error) {
      print("ERROR IN ADDING GEO FENCE");
    });
  }

  _onGeoFence(bg.GeofenceEvent event) {
    print("Welcome home!!!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            AppDimens.shape_50,
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Target:\nLatitude: 33.8688\nLongitude: 151.2093',
                  style: TextStyle(color: AppColors.white, fontSize: 24),
                ),
                AppDimens.shape_20,
                Text(
                  'Current Location',
                  style: TextStyle(color: AppColors.white, fontSize: 15),
                ),
                TextFormField(
                  controller: _latitudeController,
                  style: TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                      hintText: 'Latitude',
                      hintStyle: TextStyle(color: AppColors.white)),
                ),
                TextFormField(
                  controller: _longitudeController,
                  style: TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                      hintText: 'Longitude',
                      hintStyle: TextStyle(color: AppColors.white)),
                ),
              ],
            )),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    onClick: () {
                      setState(() {
                        Map<String, dynamic> coords = Map();
                        coords['latitude'] =
                            double.parse(_latitudeController.text.toString());
                        coords['longitude'] =
                            double.parse(_longitudeController.text.toString());
                        coords['accuracy'] = 1;
                        coords['altitude'] = 1;
                        coords['ellipsoidal_altitude'] = 1;
                        coords['heading'] = 1;
                        coords['speed'] = 1;
                        coords['floor'] = 1;
                        bg.Coords(coords);
                      });
                    },
                    text: "Start",
                  ),
                ),
                AppDimens.shape_10,
                Expanded(
                    child: AppButton(
                  onClick: () {},
                  text: "Stop",
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
