import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/main/contents_backup.dart';
import 'package:wallet_apps/src/screen/main/import_account/import_acc.dart';
import '../import_account/import_acc.dart';

class WelcomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 42,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: MyText(
                      text: AppText.welcome,
                      fontSize: 22,
                      color: AppColors.whiteColorHexa,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: MyText(
                        text: AppText.appName,
                        fontSize: 38,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColorHexa,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          SvgPicture.asset(
            'assets/undraw_wallet.svg',
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Column(
            children: [
              MyFlatButton(
                edgeMargin:
                    const EdgeInsets.only(left: 42, right: 42, bottom: 16),
                textButton: AppText.createAccTitle,
                action: () {
                  Navigator.pushNamed(context, ContentsBackup.route);
                },
              ),
              MyFlatButton(
                edgeMargin:
                    const EdgeInsets.only(left: 42, right: 42, bottom: 16),
                textButton: AppText.importAccTitle,
                action: () {
                  Navigator.pushNamed(context, ImportAcc.route);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
