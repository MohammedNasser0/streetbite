import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../l10n/app_localizations.dart';

/// A manually selected pin, independent of GPS and address geocoding.
class DeliveryPinMap extends StatefulWidget {
  const DeliveryPinMap({super.key, this.pin, this.onSelected});
  final LatLng? pin;
  final ValueChanged<LatLng>? onSelected;

  static LatLng? fromAddress(Map<String, String>? address) {
    final latitude = double.tryParse(address?['latitude'] ?? '');
    final longitude = double.tryParse(address?['longitude'] ?? '');
    if (latitude == null ||
        longitude == null ||
        !latitude.isFinite ||
        !longitude.isFinite ||
        latitude.abs() > 90 ||
        longitude.abs() > 180) {
      return null;
    }
    return LatLng(latitude, longitude);
  }

  @override
  State<DeliveryPinMap> createState() => _DeliveryPinMapState();
}

class _DeliveryPinMapState extends State<DeliveryPinMap> {
  bool _ready = false;
  bool _failed = false;
  CameraPosition get _camera => CameraPosition(
    target: widget.pin ?? const LatLng(30.0444, 31.2357),
    zoom: 13,
  );

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 210,
        child: const bool.fromEnvironment('MAPS_CONFIGURED')
            ? Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: _camera,
                    onMapCreated: (controller) async {
                      try {
                        await controller.moveCamera(
                          CameraUpdate.newCameraPosition(_camera),
                        );
                        if (mounted) setState(() => _ready = true);
                      } catch (_) {
                        if (mounted) setState(() => _failed = true);
                      }
                    },
                    onTap: (pin) {
                      if (_ready) widget.onSelected?.call(pin);
                    },
                    markers: {
                      if (widget.pin != null)
                        Marker(
                          markerId: const MarkerId('delivery-pin'),
                          position: widget.pin!,
                          infoWindow: InfoWindow(title: l.selectedPin),
                        ),
                    },
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: widget.onSelected != null,
                    scrollGesturesEnabled: widget.onSelected != null,
                    zoomGesturesEnabled: widget.onSelected != null,
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                  ),
                  if (!_ready)
                    Positioned.fill(
                      child: ColoredBox(
                        color: Theme.of(context).colorScheme.surface,
                        child: Center(
                          child: Text(_failed ? l.mapsSetup : l.mapLoading),
                        ),
                      ),
                    ),
                ],
              )
            : ColoredBox(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, size: 56),
                      Text(l.enterAddress, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
