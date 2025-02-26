import 'package:flutter/material.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/kabob_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:wallet_apps/src/models/fmt.dart';
import '../../index.dart';

class WalletProvider with ChangeNotifier {
  final WalletSDK _sdk = WalletSDK();
  final Keyring _keyring = Keyring();
  String _nativeBalance = '';
  bool _isApiConnected = false;
  bool _isSdkReady = false;
  final List<PortfolioM> _portfolioM = [];
  List<Map<String, String>> availableToken = [];

  List<Color> pieColorList = [
    hexaCodeToColor("#D65B09"),
    hexaCodeToColor(AppColors.secondary),
    hexaCodeToColor("#F0C90A"),
  ];

  Map<String, double> dataMap = {
    'SEL': 100.0,
    'KMPI': 0.0,
    'ATD': 0.0,
  };

  WalletSDK get sdk => _sdk;
  Keyring get keyring => _keyring;
  List<PortfolioM> get portfolio => _portfolioM;
  String get nativeBalance => _nativeBalance;
  bool get isApiConnected => _isApiConnected;

  Future<void> initApi() async {
    await keyring.init();
    await sdk.init(keyring);

    // ignore: join_return_with_assignment
    _isSdkReady = true;
    return _isSdkReady;
  }

  Future<void> connectNetwork() async {
    final node = NetworkParams();

    node.name = 'Indranet hosted By Selendra';
    node.endpoint = 'wss://rpc-testnet.selendra.org';
    node.ss58 = 42;

    final res = await sdk.api.connectNode(keyring, [node]);

    if (res != null) {
      _isApiConnected = true;
    }

    notifyListeners();
  }

  Future<void> subscribeBalance() async {
    await sdk.api.account.subscribeBalance(keyring.current.address, (res) {
      if (res != null) {
        _nativeBalance = Fmt.balance(res.freeBalance.toString(), 18);
      }
    });
    notifyListeners();
  }

  void addAvaibleToken(Map<String, String> token) {
    availableToken.add(token);
    notifyListeners();
  }

  void updateAvailableToken(Map<String, String> token) {
    for (int i = 0; i < availableToken.length; i++) {
      if (availableToken[i]['symbol'] == token['symbol']) {
        availableToken[i].update('balance', (value) => token['balance']);
      } else {
        addAvaibleToken(token);
      }
    }
    notifyListeners();
  }

  void removeAvailableToken(Map<String, String> token) {
    availableToken.remove(token);
    notifyListeners();
  }

  void clearPortfolio() {
    availableToken.clear();
    _portfolioM.clear();
    notifyListeners();
  }

  Future<double> getTotal() async {
    double total = 0;

    for (int i = 0; i < availableToken.length; i++) {
      total = total + double.parse(availableToken[i]['balance']);
    }
    return total;
  }

  void resetDatamap() {
    dataMap.update('SEL', (value) => value = 100);
    dataMap.update('KMPI', (value) => value = 0);
    dataMap.update('ATD', (value) => value = 0);
    notifyListeners();
  }

  Future<void> getPortfolio() async {
    _portfolioM.clear();

    double temp = 0.0;

    await getTotal().then((total) {
      double percen = 0.0;
      for (int i = 0; i < availableToken.length; i++) {
        temp = double.parse(availableToken[i]['balance']) / total;

        if (total == 0.0) {
          _portfolioM.add(PortfolioM(
              color: pieColorList[i],
              symbol: availableToken[i]['symbol'],
              percentage: '0'));
        } else {
          if (availableToken[i]['symbol'] == 'SEL') {
            percen = temp * 100;
            _portfolioM.add(PortfolioM(
              color: pieColorList[0],
              symbol: 'SEL',
              percentage: percen.toStringAsFixed(4),
            ));
            dataMap.update('SEL',
                (value) => value = double.parse(percen.toStringAsFixed(4)));
          } else if (availableToken[i]['symbol'] == 'KMPI') {
            percen = temp * 100;
            _portfolioM.add(PortfolioM(
                color: pieColorList[1],
                symbol: 'KMPI',
                percentage: percen.toStringAsFixed(4)));
            dataMap.update('KMPI',
                (value) => value = double.parse(percen.toStringAsFixed(4)));
          } else if (availableToken[i]['symbol'] == 'ATD') {
            percen = temp * 100;
            _portfolioM.add(PortfolioM(
                color: pieColorList[2],
                symbol: 'ATD',
                percentage: percen.toStringAsFixed(4)));
            dataMap.update('ATD',
                (value) => value = double.parse(percen.toStringAsFixed(4)));
          }
        }
      }
    });

    notifyListeners();
  }
}
