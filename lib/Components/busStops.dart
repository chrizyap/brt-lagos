import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStops {
  static final Map busStopMap = {
    "TBS Terminal": _tbsTerminal,
    "CMS Terminal": _cmsTerminal,
    "Leventis": _leventis,
    "Costain": _costain,
    "Iponri": _iponri,
    "Stadium": _stadium,
    "Barracks": _barracks,
    "Moshalashi Terminal": _moshalashiTerminal,
    "Fadeyi": _fadeyi,
    "Onipanu": _onipanu,
    "Palmgrove": _palmgrove,
    "Obanikoro": _obanikoro,
    "Anthony": _anthony,
    "Idiroko": _idiroko,
    "Maryland": _maryland,
    "New Garage": _newGarage,
    "Ojota": _ojota,
    "Ketu": _ketu,
    "Mile 12 Terminal": _mile12Terminal,
    "Owode Onirun": _owodeOnirun,
    "Idera": _idera,
    "Irawo": _irawo,
    "MajidunAwori": _majidunAwori,
    "MajidunOgolunto": _majidunOgolunto,
    "Argic Terminal": _argicTerminal,
    "Ikorodu Terminal": _ikoroduTerminal,
  };

  static LatLng _tbsTerminal = LatLng(6.445721, 3.401200);
  static LatLng _cmsTerminal = LatLng(6.451145, 3.389201);
  static LatLng _leventis = LatLng(6.455254, 3.380983);
  static LatLng _costain = LatLng(6.480660, 3.367996);
  static LatLng _iponri = LatLng(6.487398, 3.364117);
  static LatLng _stadium = LatLng(6.501144, 3.362595);
  static LatLng _barracks = LatLng(6.506293, 3.363750);
  static LatLng _moshalashiTerminal = LatLng(6.519948, 3.364994);
  static LatLng _fadeyi = LatLng(6.528089, 3.367087);
  static LatLng _onipanu = LatLng(6.534815, 3.366926);
  static LatLng _palmgrove = LatLng(6.541314, 3.367351);
  static LatLng _obanikoro = LatLng(6.547142, 3.366773);
  static LatLng _anthony = LatLng(6.558832, 3.367001);
  static LatLng _idiroko = LatLng(6.565531, 3.366500);
  static LatLng _maryland = LatLng(6.571467, 3.367076);
  static LatLng _newGarage = LatLng(6.584761, 3.376472);
  static LatLng _ojota = LatLng(6.587780, 3.378858);
  static LatLng _ketu = LatLng(6.597003, 3.385641);
  static LatLng _mile12Terminal = LatLng(6.606810, 3.399453);
  static LatLng _owodeOnirun = LatLng(6.611326, 3.411039);
  static LatLng _idera = LatLng(6.610537, 3.420705);
  static LatLng _irawo = LatLng(6.609840, 3.422123);
  static LatLng _majidunAwori = LatLng(6.619691, 3.462980);
  static LatLng _majidunOgolunto = LatLng(6.619959, 3.473586);
  static LatLng _argicTerminal = LatLng(6.625813, 3.483925);
  //LatLng _agic = LatLng(6.445721,3.401200); Basically the same as Agric Terminal
  //LatLng _abuna = LatLng(6.445721,3.401200); Can't find it on Gmaps
  static LatLng _ikoroduTerminal = LatLng(6.621859, 3.502544);

  static final Map busStopIndex = {
    "TBS Terminal": 1,
    "CMS Terminal": 2,
    "Leventis": 3,
    "Costain": 4,
    "Iponri": 5,
    "Stadium": 6,
    "Barracks": 7,
    "Moshalashi Terminal": 8,
    "Fadeyi": 9,
    "Onipanu": 10,
    "Palmgrove": 11,
    "Obanikoro": 12,
    "Anthony": 13,
    "Idiroko": 14,
    "Maryland": 15,
    "New Garage": 16,
    "Ojota": 17,
    "Ketu": 18,
    "Owode Onirun": 19,
    "Mile 12 Terminal": 20,
    "Idera": 21,
    "Irawo": 22,
    "MajidunAwori": 23,
    "MajidunOgolunto": 24,
    "Argic Terminal": 25,
    "Ikorodu Terminal": 26,
  };
}
