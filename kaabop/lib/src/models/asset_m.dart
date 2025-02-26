import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ModelAsset {
  bool enable = false;
  bool loading = false;
  bool match = false;
  bool added = false;

  String assetBalance = '0';
  static const String assetSymbol = 'KMPI';
  static const String assetOrganization = 'KOOMPI';

  String responseAssetCode;
  String responseIssuer;

  GlobalKey<FormState> formStateAsset = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> result;

  TextEditingController controllerAssetCode = TextEditingController();
  TextEditingController controllerIssuer = TextEditingController();

  FocusNode nodeAssetCode = FocusNode();
  FocusNode nodeIssuer = FocusNode();
}
