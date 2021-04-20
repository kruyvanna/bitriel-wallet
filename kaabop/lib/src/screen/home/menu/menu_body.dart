import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/index.dart';

class MenuBody extends StatelessWidget {
  final Map<String, dynamic> userInfo;
  final MenuModel model;
  final Function switchBio;

  const MenuBody({
    this.userInfo,
    this.model,
    this.switchBio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuHeader(userInfo: userInfo),

        // History
        const MenuSubTitle(index: 0),

        MyListTile(
          index: 0,
          subIndex: 0,
          onTap: () {
            Navigator.pop(context, '');
            Navigator.pushNamed(
              context,
              AppText.txActivityView,
            );
          },
        ),

        // Wallet
        const MenuSubTitle(index: 1),

        MyListTile(
          index: 1,
          subIndex: 0,
          onTap: () {
            Navigator.pushNamed(context, AppText.recieveWalletView);
          },
        ),

        MyListTile(
          index: 1,
          subIndex: 1,
          onTap: () {
            Navigator.push(context, RouteAnimation(enterPage: AddAsset()));
          },
        ),

        // Security
        const MenuSubTitle(index: 2),
        MyListTile(
          index: 2,
          subIndex: 0,
          onTap: () {
            Navigator.pushNamed(context, AppText.claimAirdropView);
          },
        ),
        MyListTile(
          index: 2,
          subIndex: 1,
          onTap: () {
            //Navigator.pushNamed(context, AppText.claimAirdropView);
          },
        ),

        // Account
        const MenuSubTitle(index: 3),

        MyListTile(
          enable: false,
          index: 3,
          subIndex: 0,
          trailing: Switch(
            value: model.switchPasscode,
            onChanged: (value) {
              Navigator.pushNamed(context, AppText.passcodeView);
            },
          ),
          onTap: null,
        ),

        MyListTile(
          enable: false,
          index: 3,
          subIndex: 1,
          trailing: Switch(
            value: model.switchBio,
            onChanged: (value) {
              switchBio(value);
            },
          ),
          onTap: null,
        ),
        const MenuSubTitle(index: 4),

        MyListTile(
          index: 3,
          subIndex: 0,
          onTap: () async {
            Navigator.popAndPushNamed(context, AppText.accountView);
          },
        ),
      ],
    );
  }
}
