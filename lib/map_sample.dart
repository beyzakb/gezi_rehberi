import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

const String googleAPIKey = 'AIzaSyBH86668Dk5QL7V0pNdVllrFRia05WZVCs'; // Google API anahtarınızı buraya ekleyin

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const LatLng _origin = LatLng(41.0396, 28.8562); // Başlangıç noktası koordinatları
  static const LatLng _destination = LatLng(41.0332, 28.8533); // Varış noktası koordinatları

  List<LatLng> polylineCoordinates = []; // Çizgi koordinatları
  Set<Marker> markers = {}; // İşaretçiler (marker'lar)
  Set<Polyline> polylines = {}; // Çizgiler (polylines)

  @override
  void initState() {
    super.initState();
    _addMarkers(); // İşaretçileri haritaya ekleyen fonksiyonu çağır
    _getPolyline(); // Yol çizgisini almak için API isteğini yap
  }

  void _addMarkers() {
    // Başlangıç noktası için işaretçi ekle
    markers.add(Marker(
      markerId: MarkerId('origin'),
      position: _origin,
      infoWindow: InfoWindow(title: 'Başlangıç Noktası: Kültür Merkezi'), // Bilgi penceresi içeriği
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // İkon rengi
    ));

    // Varış noktası için işaretçi ekle
    markers.add(Marker(
      markerId: MarkerId('destination'),
      position: _destination,
      infoWindow: InfoWindow(title: 'Varış Noktası: Halk Sarayı'), // Bilgi penceresi içeriği
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // İkon rengi
    ));
  }

  Future<void> _getPolyline() async {
    // Yol çizgisini almak için API isteği oluştur
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_origin.latitude},${_origin.longitude}&destination=${_destination.latitude},${_destination.longitude}&mode=driving&key=$googleAPIKey';

    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);

    if (json['routes'].isNotEmpty) {
      final points = json['routes'][0]['overview_polyline']['points']; // Çizgi noktalarını al
      polylineCoordinates = _decodePolyline(points); // Kodlanmış çizgiyi çöz ve koordinat listesine ekle
      setState(() {
        polylines.add(Polyline(
          polylineId: PolylineId('route'),
          points: polylineCoordinates,
          width: 6,
          color: Colors.blue,
        )); // Çizgiyi ekleyerek haritaya görsel olarak çiz
      });
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    // Kodlanmış çizgiyi çözerek koordinat listesi oluştur
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }

    return polyline;
  }

  void _launchMapApp() async {
    // Google Haritalar uygulamasını açmak için URL oluştur ve aç
    final url = 'https://www.google.com/maps/search/?api=1&query=${_destination.latitude},${_destination.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showOpenMapDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Kullanıcı dışarıya tıklamadan kapatamaz
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Harita Açma İsteği'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Haritayı Google Haritalar uygulamasında mı açmak istiyorsunuz?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Evet'),
              onPressed: () {
                Navigator.of(context).pop(); // Uyarıyı kapat
                _launchMapApp(); // Haritayı aç
              },
            ),
            TextButton(
              child: Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop(); // Uyarıyı kapat
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () {
          _showOpenMapDialog(); // Haritaya çift tıklama işlemini başlat
        },
        child: GoogleMap(
          mapType: MapType.normal, // Harita türü (uydu ve sokak görünümü)
          initialCameraPosition: CameraPosition(target: _origin, zoom: 14), // Başlangıç kamera konumu
          markers: markers, // İşaretçileri (marker'lar) göster
          polylines: polylines, // Çizgileri (polylines) göster
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller); // Harita oluşturulduğunda controller'ı tamamla
          },
        ),
      ),
    );
  }
}
