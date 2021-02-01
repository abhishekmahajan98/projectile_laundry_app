import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:projectilelaundryapp/components/signup_container.dart';
import 'package:projectilelaundryapp/constants.dart';
import 'package:projectilelaundryapp/providers/user_data_provider.dart';
import 'package:projectilelaundryapp/services/authentication_service.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/services/firestore_service.dart';
import 'package:projectilelaundryapp/services/shared_preferences_service.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class UserInfoInputPage extends StatefulWidget {
  @override
  _UserInfoInputPageState createState() => _UserInfoInputPageState();
}

class _UserInfoInputPageState extends State<UserInfoInputPage> {
  GoogleMapController _controller;
  geolocator.Position currentPosition =
      geolocator.Position(latitude: 12.9716, longitude: 77.5946);
  //String locality = '', pincode = '', administrativeArea = '', placeName = '';
  String inputAddress = '',
      inputLandmark = '',
      inputName = '',
      inputPhoneNumber = '',
      inputPincode = '',
      inputCity = '';
  void submitData() async {
    //sign in
    final _authService = AuthenticationService(_auth);
    final email = context.read(signupEmailProvider).state;
    final password = context.read(signupPasswordProvider).state;
    int signupRes =
        await _authService.emailSignUp(email: email, password: password);
    if (signupRes == 1) {
      // upload data to db
      final _dbService = FireStoreService(_firestore, _auth.currentUser.uid);
      final assignedShop = await _dbService.getClosestShopInRange(
          userLat: currentPosition.latitude,
          userLong: currentPosition.longitude);
      final uploadData = {
        'name': inputName,
        'phoneNumber': inputPhoneNumber,
        'uid': _auth.currentUser.uid,
        'email': _auth.currentUser.email,
        'selectedAddressIndex': 0,
        'address': [
          {
            'address': inputAddress,
            'city': inputCity,
            'pincode': inputPincode,
            'landmark': inputLandmark,
            'latitude': currentPosition.latitude,
            'longitude': currentPosition.longitude,
            'assignedShop': assignedShop.tojson(),
          },
        ],
      };
      await _dbService.uploadUserData(uploadData);

      //get data back again and load to the userDataProvider
      final user = context.read(userDataProvider);
      await _dbService.getUserData().then((value) {
        user.assignUser(value);
      });
      // save to prefs
      final prefs = SharedPreferencesService();
      await prefs.saveToPrefs(user.activeUser);
      //navigate to home
      print(assignedShop.name);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    geolocator.LocationPermission permission;

    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == geolocator.LocationPermission.denied) {
      permission = await geolocator.Geolocator.requestPermission();
      if (permission != geolocator.LocationPermission.whileInUse &&
          permission != geolocator.LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    final pos = await geolocator.Geolocator.getCurrentPosition(
      desiredAccuracy: geolocator.LocationAccuracy.high,
    );
    setState(() {
      currentPosition = pos;
    });
    print(
      'current position: (' +
          currentPosition.longitude.toString() +
          ',' +
          currentPosition.latitude.toString() +
          ')',
    );
    moveCameraToPosition(currentPosition);
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  void getCurrentLocation() async {
    geolocator.Position position;
    position = await geolocator.Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high);
    if (position.longitude == null || position.latitude == null) {
      position = await geolocator.Geolocator.getLastKnownPosition();
    }
    setState(() {
      currentPosition = position;
      //print(currentPosition.latitude.toString());
    });
    moveCameraToPosition(currentPosition);
    //getAddressFromPosition(currentPosition);
  }

  void moveCameraToPosition(geolocator.Position position) {
    _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18,
        ),
      ),
    );
  }

  void _updatePosition(CameraPosition _position) {
    geolocator.Position newPosition = geolocator.Position(
        latitude: _position.target.latitude,
        longitude: _position.target.longitude);
    setState(() {
      currentPosition = newPosition;
    });
    print(
      'current position: (' +
          currentPosition.latitude.toString() +
          ',' +
          currentPosition.longitude.toString() +
          ')',
    );
    moveCameraToPosition(currentPosition);
  }

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(12.9716, 77.5946),
    zoom: 14.4746,
  );

  void getCustomLocation() async {
    Prediction pred = await PlacesAutocomplete.show(
      context: context,
      strictbounds: currentPosition == null ? false : true,
      apiKey: "AIzaSyCDQL-c9ksJeY92-s8wbKlruG90K8uqI_o",
      mode: Mode.fullscreen,
      language: "en",
      location: Location(currentPosition.latitude, currentPosition.longitude),
      radius: currentPosition == null ? null : 100000,
      components: [Component(Component.country, "in")],
    );
    if (pred != null) {
      List<geocoding.Location> locations =
          await geocoding.locationFromAddress(pred.description.toString());
      //getLocationFromAddress(plcmrk[0]);
      setState(() {
        currentPosition = geolocator.Position(
          latitude: locations[0].latitude,
          longitude: locations[0].longitude,
        );
      });
      moveCameraToPosition(currentPosition);
    }
  }

  Widget getTF(String label, Function onChanged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: mainColor,
          ),
        ),
      ),
    );
  }

  Widget getTitleRow(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: mainColor,
              height: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: mainColor,
              height: 3,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blurredMainColor,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (controller) => mapCreated(controller),
                    markers: Set.of(<Marker>[
                      Marker(
                        markerId: MarkerId('currentPos'),
                        position: LatLng(currentPosition.latitude,
                            currentPosition.longitude),
                      ),
                    ]),
                    onCameraMove: ((_position) => _updatePosition(_position)),
                  ),
                ),
                Card(
                  color: blurredMainColor,
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: mainColor,
                    ),
                    title: GestureDetector(
                      onTap: () => getCustomLocation(),
                      child: Text(
                        'Search for a location',
                        style: TextStyle(color: mainColor),
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () => _determinePosition(),
                      child: Icon(
                        Icons.location_searching,
                        color: mainColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getTitleRow("Personal Details"),
                    getTF('Name', (value) {
                      setState(() {
                        inputName = value;
                      });
                    }),
                    getTF('Phone Number', (value) {
                      setState(() {
                        inputPhoneNumber = value;
                      });
                    }),
                    getTitleRow("Pickup/Delivery Address Details"),
                    getTF('Address', (value) {
                      setState(() {
                        inputAddress = value;
                      });
                    }),
                    getTF('Landmark', (value) {
                      setState(() {
                        inputLandmark = value;
                      });
                    }),
                    getTF('City', (value) {
                      setState(() {
                        inputCity = value;
                      });
                    }),
                    getTF('Pincode', (value) {
                      setState(() {
                        inputPincode = value;
                      });
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        child: RaisedButton(
                          color: mainColor,
                          onPressed: () => submitData(),
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: blurredMainColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
