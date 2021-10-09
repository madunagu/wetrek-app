// import 'dart:io';
// import 'dart:ui';

// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:wetrek/models/location.dart';

// import 'trek_event.dart';
// import 'trek_region.dart';

// void callbackDispatcher() {
//   // 1. Initialize MethodChannel used to communicate with the platform portion of the plugin.
//   const MethodChannel _backgroundChannel =
//       MethodChannel('plugins.flutter.io/geofencing_plugin_background');

//   // 2. Setup internal state needed for MethodChannels.
//   WidgetsFlutterBinding.ensureInitialized();

//   // 3. Listen for background events from the platform portion of the plugin.
//   _backgroundChannel.setMethodCallHandler((MethodCall call) async {
//     final args = call.arguments;

//     // 3.1. Retrieve callback instance for handle.
//     final Function? callback = PluginUtilities.getCallbackFromHandle(
//         CallbackHandle.fromRawHandle(args[0]));
//     assert(callback != null);

//     // 3.2. Preprocess arguments.
//     final triggeringGeofences = args[1].cast<String>();
//     final locationList = args[2].cast<double>();
//     final triggeringLocation = locationFromList(locationList);
//     final TrekEvent event = intToGeofenceEvent(args[3]);

//     // 3.3. Invoke callback.
//     callback!(triggeringGeofences, triggeringLocation, event);
//   });

//   // 4. Alert plugin that the callback handler is ready for events.
//   _backgroundChannel.invokeMethod('GeofencingService.initialized');
// }

// abstract class GeofencingPlugin {
//   static const MethodChannel _channel =
//       const MethodChannel('plugins.flutter.io/geofencing_plugin');

//   static Future<void> initialize() async {
//     final callback = PluginUtilities.getCallbackHandle(callbackDispatcher);
//     await _channel.invokeMethod('GeofencingPlugin.initializeService',
//         <dynamic>[callback!.toRawHandle()]);
//   }

//   static Future<void> registerGeofence(
//       TrekRegion region,
//       void Function(List<String> id, Location location, TrekEvent event)
//           callback) async {
//     if (Platform.isIOS &&
//         region.triggers.contains(TrekEvent.dwell) &&
//         (region.triggers.length == 1)) {
//       throw UnsupportedError("iOS does not support 'GeofenceEvent.dwell'");
//     }
//     final args = <dynamic>[
//       PluginUtilities.getCallbackHandle(callback)!.toRawHandle()
//     ];
//     args.addAll(region._toArgs());
//     _channel.invokeMethod('GeofencingPlugin.registerGeofence', args);
//   }

//   /*
//   * … `removeGeofence` methods here …
//   */
// }
