import 'package:flutter/material.dart';

// // app routes for the app
// var appRoutes = {
//   List: (context) => ListImagesPage(),
//   viewImage: (context) => ViewImagePage(),
//   imageUpload: (context) => UploadImagePage(),
// };

// home screen route
const List<Map<String, dynamic>> navigationDestinations = [
  {
    'label': 'Home',
    'icon': Icon(Icons.home_outlined),
    'tooltip': 'Home',
    'selectedIcon': Icon(Icons.home),
  },
  {
    'label': 'Upload',
    'icon': Icon(Icons.cloud_upload_outlined),
    'tooltip': 'Upload',
    'selectedIcon': Icon(Icons.cloud_upload),
  },
];

// the navigation destinations for bottom navigation
List<NavigationDestination> destinations = navigationDestinations
    .map((destination) => NavigationDestination(
          label: destination['label'],
          icon: destination['icon'],
          tooltip: destination['tooltip'],
          selectedIcon: destination['selectedIcon'],
        ))
    .toList();

// the navigation destinations for navigation rail
List<NavigationRailDestination> railDestinations = navigationDestinations
    .map(
      (destination) => NavigationRailDestination(
        icon: destination['icon'],
        selectedIcon: destination['selectedIcon'],
        indicatorColor: Colors.amber,
        indicatorShape: const CircleBorder(),
        label: Text(destination['label'] as String),
      ),
    )
    .toList();
