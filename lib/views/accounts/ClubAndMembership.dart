import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/view_models/UserInfoProvider.dart';
import 'package:qantum_apps/views/accounts/widgets/EnterClubCodeCard.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/MyAccountProvider.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../core/flavors_config/flavor_config.dart';
import '/views/common_widgets/AppCustomButton.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../common_widgets/AppScaffold.dart';
import 'widgets/AccountsAppBar.dart';
import 'widgets/AddedClubCodeCard.dart';

class ClubAndMembership extends StatefulWidget {
  const ClubAndMembership({super.key});

  @override
  State<ClubAndMembership> createState() => _ClubAndMembershipState();
}

class _ClubAndMembershipState extends State<ClubAndMembership> {
  Flavor selectedFlavor = FlavorConfig.instance.flavor!;

  MyAccountProvider myAccountProvider = MyAccountProvider();
  late AppLocalizations loc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserInfoProvider>().fetchUserActiveSponsorship();
    });
  }

  @override
  void dispose() {
    myAccountProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(
      scaffoldBackground: AppThemeCustom.getAccountBackground(context),
      body: ChangeNotifierProvider(
        create: (context) => myAccountProvider,
        child: SafeArea(
          child: Consumer2<MyAccountProvider, UserInfoProvider>(
              builder: (context, provider, userProvider, child) {
            // DISPLAYING NETWORK RESPONSE
            if (userProvider.networkError != null) {
              Future.delayed(Duration.zero, () {
                if (userProvider.networkError!) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    AppHelper.showErrorMessage(
                        context, userProvider.networkResponse ?? "");
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    AppHelper.showSuccessMessage(
                        context, userProvider.networkResponse ?? "");
                  });
                }
                Future.delayed(Duration.zero, () {
                  userProvider.resetNetworkResponseStatus();
                });
              });
            }

            return Stack(
              children: [
                Column(
                  children: [
                    AccountsAppBar(
                        showBackButton: true,
                        title: provider.getClubSponsorshipTitle(loc)),
                    Expanded(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Theme.of(context).canvasColor,
                      ),
                      child: SingleChildScrollView(
                        child: (userProvider.fetchingActiveSponsorship)
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppDimens.shape_10,
                                  Text(
                                    (userProvider.activeSponsorship != null)
                                        ? loc.msgActiveSponsorshipHeader
                                        : loc.msgObtainClubCode,
                                    style: TextStyle(
                                        color: AppThemeCustom
                                            .getAccountSectionItemStyle(
                                                context)),
                                  ),
                                  AppDimens.shape_20,
                                  (userProvider.activeSponsorship != null &&
                                          !userProvider.activeUpdateSponsorship)
                                      ? AddedClubCodeCard(
                                          activeSponsorship:
                                              userProvider.activeSponsorship!,
                                        )
                                      : const EnterClubCodeCard()
                                ],
                              ),
                      ),
                    )),
                  ],
                ),
                userProvider.showLoader != null && userProvider.showLoader!
                    ? AppLoader()
                    : Container(),
                userProvider.fetchingActiveSponsorship
                    ? AppLoader()
                    : Container(),
                userProvider.showRemoveSponsorshipLoader
                    ? AppLoader()
                    : Container(),
                userProvider.checkingSponsorshipDetail
                    ? AppLoader(
                        loaderMessage: loc.msgPleaseWait,
                      )
                    : Container(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
