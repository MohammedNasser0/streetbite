import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../l10n/app_localizations.dart';

class VendorMapScreen extends StatelessWidget {
  const VendorMapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final arabic = Localizations.localeOf(context).languageCode == 'ar';
    const points = [
      LatLng(30.0444, 31.2357),
      LatLng(31.2001, 29.9187),
      LatLng(25.6872, 32.6396),
      LatLng(24.0889, 32.8998),
      LatLng(27.2579, 33.8116),
    ];
    final names = arabic
        ? [
            'بايت القاهرة',
            'بايت الإسكندرية',
            'بايت الأقصر',
            'بايت أسوان',
            'بايت الغردقة',
          ]
        : [
            'Cairo Bite',
            'Alexandria Bite',
            'Luxor Bite',
            'Aswan Bite',
            'Hurghada Bite',
          ];
    return Scaffold(
      appBar: AppBar(title: Text(l.vendors)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(l.demoVendors),
          ),
          Expanded(
            child: const bool.fromEnvironment('MAPS_CONFIGURED')
                ? GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(27.8, 31.7),
                      zoom: 5,
                    ),
                    markers: {
                      for (var i = 0; i < points.length; i++)
                        Marker(
                          markerId: MarkerId('$i'),
                          position: points[i],
                          infoWindow: InfoWindow(
                            title: names[i],
                            snippet:
                                '${arabic ? 'طعام الشارع' : 'Street food'} • 4.5 ★',
                          ),
                        ),
                    },
                  )
                : Center(child: Text(l.mapsSetup)),
          ),
        ],
      ),
    );
  }
}
