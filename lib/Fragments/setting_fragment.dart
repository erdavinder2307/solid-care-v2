import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:solidcare/components/cached_image_widget.dart';
import 'package:solidcare/components/loader_widget.dart';
import 'package:solidcare/components/setting_third_page.dart';
import 'package:solidcare/components/status_widget.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/components/doctor_recentionist_general_setting_component.dart';
import 'package:solidcare/components/app_setting_component.dart';
import 'package:solidcare/screens/auth/components/edit_profile_component.dart';
import 'package:solidcare/screens/patient/components/general_setting_component.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingFragment extends StatefulWidget {
  @override
  _SettingFragmentState createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SafeArea(
          child: AnimatedScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 60),
            listAnimationType: ListAnimationType.None,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditProfileComponent(refreshCallback: () {
                setStatusBarColor(
                  appStore.isDarkModeOn
                      ? context.scaffoldBackgroundColor
                      : appPrimaryColor.withOpacity(0.02),
                  statusBarIconBrightness: appStore.isDarkModeOn
                      ? Brightness.light
                      : Brightness.dark,
                );
                setState(() {});
              }),
              Divider(height: isReceptionist() || isPatient() ? 30 : 40),
              Text(locale.lblGeneralSetting,
                  textAlign: TextAlign.center, style: secondaryTextStyle()),
              16.height,
              if (isPatient())
                GeneralSettingComponent(callBack: () => setState(() {})),
              if (isDoctor() || isReceptionist())
                DoctorReceptionistGeneralSettingComponent(),
              24.height,
              Text(locale.lblAppSettings,
                  textAlign: TextAlign.center, style: secondaryTextStyle()),
              16.height,
              AppSettingComponent(callSetState: () => setState),
              24.height,
              Text(locale.lblOther,
                  textAlign: TextAlign.center, style: secondaryTextStyle()),
              SettingThirdPage(),
            ],
          ),
        ),
        Observer(
            builder: (context) => LoaderWidget().visible(appStore.isLoading))
      ],
    );
  }
}
