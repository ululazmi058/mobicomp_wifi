import 'package:flutter/material.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wi-Fi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WifiInfoScreen(),
    );
  }
}

class WifiInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wi-Fi Info'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (await Permission.location.request().isGranted) {
              try {
                var wifiSsid = await WifiInfo().getWifiName();
                var wifiIp = await WifiInfo().getWifiIP();
                var wifiBssid = await WifiInfo().getWifiBSSID();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Wi-Fi Info'),
                      content: Text('SSID: $wifiSsid\n'
                          'IP Address: $wifiIp\n'
                          'BSSID: $wifiBssid\n'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Failed to get Wi-Fi info: $e'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Permission Denied'),
                    content: Text(
                        'Location permission is required to get Wi-Fi info.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Get Wi-Fi Info'),
        ),
      ),
    );
  }
}
