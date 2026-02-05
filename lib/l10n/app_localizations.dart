import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('zh'),
    Locale('zh', 'CN')
  ];

  /// No description provided for @txtWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get txtWelcome;

  /// No description provided for @txtEnterYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your mobile number'**
  String get txtEnterYourNumber;

  /// No description provided for @txtOk.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get txtOk;

  /// No description provided for @txtChangeMyMobile.
  ///
  /// In en, this message translates to:
  /// **'{change} my mobile'**
  String txtChangeMyMobile(Object change);

  /// No description provided for @txtChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get txtChange;

  /// No description provided for @txtDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get txtDate;

  /// No description provided for @txtTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get txtTime;

  /// No description provided for @txtCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get txtCard;

  /// No description provided for @txtYourUsage.
  ///
  /// In en, this message translates to:
  /// **'Your Usage '**
  String get txtYourUsage;

  /// No description provided for @txtDaily.
  ///
  /// In en, this message translates to:
  /// **'(Daily)'**
  String get txtDaily;

  /// No description provided for @txtLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get txtLoading;

  /// No description provided for @txtManageLimits.
  ///
  /// In en, this message translates to:
  /// **'Manage Limits'**
  String get txtManageLimits;

  /// No description provided for @txtActivitySnapshot.
  ///
  /// In en, this message translates to:
  /// **'Activity Snapshot'**
  String get txtActivitySnapshot;

  /// No description provided for @txtGamingSupport.
  ///
  /// In en, this message translates to:
  /// **'Gaming Support'**
  String get txtGamingSupport;

  /// No description provided for @txtSelfExclusion.
  ///
  /// In en, this message translates to:
  /// **'Self Exclusion'**
  String get txtSelfExclusion;

  /// No description provided for @msgTimeAndSpendLimits.
  ///
  /// In en, this message translates to:
  /// **'Time and spend limits allow you to manage and track your gaming activity'**
  String get msgTimeAndSpendLimits;

  /// No description provided for @msgSeeYourPointHistory.
  ///
  /// In en, this message translates to:
  /// **'See your point history'**
  String get msgSeeYourPointHistory;

  /// No description provided for @msgFindSupport.
  ///
  /// In en, this message translates to:
  /// **'Find the right support for you'**
  String get msgFindSupport;

  /// No description provided for @msgSetSelfExclusion.
  ///
  /// In en, this message translates to:
  /// **'Set self exclusion privately & confidentially'**
  String get msgSetSelfExclusion;

  /// No description provided for @msgCommunicationPreference.
  ///
  /// In en, this message translates to:
  /// **'Please allow up to 24 hours for changes to take affect.'**
  String get msgCommunicationPreference;

  /// No description provided for @msgNotificationPreference.
  ///
  /// In en, this message translates to:
  /// **'How would you like to be notified?'**
  String get msgNotificationPreference;

  /// No description provided for @msgKeepingInTouch.
  ///
  /// In en, this message translates to:
  /// **'Keeping in touch allows us to offer prizes,\nrewards & promotions.'**
  String get msgKeepingInTouch;

  /// No description provided for @msgSelectCommunicationPreference.
  ///
  /// In en, this message translates to:
  /// **'Below you can select how we can keep in touch with you.'**
  String get msgSelectCommunicationPreference;

  /// No description provided for @msgObtainClubCode.
  ///
  /// In en, this message translates to:
  /// **'Obtain your club code then enter it below and earn rewards & get benefits for your club.'**
  String get msgObtainClubCode;

  /// No description provided for @txtHowToEarnStatusCredits.
  ///
  /// In en, this message translates to:
  /// **'HOW TO EARN STATUS CREDITS'**
  String get txtHowToEarnStatusCredits;

  /// No description provided for @msgVerifyAccountAndProceed.
  ///
  /// In en, this message translates to:
  /// **'Please hold on while we verify your account and send the OTP.'**
  String get msgVerifyAccountAndProceed;

  /// No description provided for @txtVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get txtVerificationCode;

  /// No description provided for @txtContactVenueSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact venue support'**
  String get txtContactVenueSupport;

  /// No description provided for @txtThereWasError.
  ///
  /// In en, this message translates to:
  /// **'There was an error!'**
  String get txtThereWasError;

  /// No description provided for @msgRecoverEmailError.
  ///
  /// In en, this message translates to:
  /// **'There was no email registered with this account. Please contact venue support.'**
  String get msgRecoverEmailError;

  /// No description provided for @txtEnterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code'**
  String get txtEnterVerificationCode;

  /// No description provided for @msgEnterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'We sent a code to mobile number '**
  String get msgEnterVerificationCode;

  /// No description provided for @txtSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get txtSubmit;

  /// No description provided for @txtRedeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get txtRedeem;

  /// No description provided for @txtMoreInfo.
  ///
  /// In en, this message translates to:
  /// **'More Info'**
  String get txtMoreInfo;

  /// No description provided for @txtCongratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get txtCongratulations;

  /// No description provided for @txtMyAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get txtMyAccount;

  /// No description provided for @txtSaveAndUpdate.
  ///
  /// In en, this message translates to:
  /// **'Save And Update'**
  String get txtSaveAndUpdate;

  /// No description provided for @txtUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get txtUpdate;

  /// No description provided for @txtReturnToLogin.
  ///
  /// In en, this message translates to:
  /// **'Return to login'**
  String get txtReturnToLogin;

  /// No description provided for @txtLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get txtLogin;

  /// No description provided for @txtSendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get txtSendVerificationCode;

  /// No description provided for @txtRecoverYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Recover your account'**
  String get txtRecoverYourAccount;

  /// No description provided for @msgEnterMobileNoToRecoverYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Enter the mobile number you used to register your account.\nWe’ll send you a recovery code to your email address.'**
  String get msgEnterMobileNoToRecoverYourAccount;

  /// No description provided for @txtPromotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get txtPromotions;

  /// No description provided for @txtMyBenefits.
  ///
  /// In en, this message translates to:
  /// **'My Benefits'**
  String get txtMyBenefits;

  /// No description provided for @txtPointsBalance.
  ///
  /// In en, this message translates to:
  /// **'Points Balance'**
  String get txtPointsBalance;

  /// No description provided for @txtSpecialOffers.
  ///
  /// In en, this message translates to:
  /// **'Special Offers'**
  String get txtSpecialOffers;

  /// No description provided for @txtWhatsOn.
  ///
  /// In en, this message translates to:
  /// **'What\'s On'**
  String get txtWhatsOn;

  /// No description provided for @txtPartnerOffers.
  ///
  /// In en, this message translates to:
  /// **'Partner Offers'**
  String get txtPartnerOffers;

  /// No description provided for @txtSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get txtSeeAll;

  /// No description provided for @txtBookRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Book\nRestaurant'**
  String get txtBookRestaurant;

  /// No description provided for @txtBusTimetable.
  ///
  /// In en, this message translates to:
  /// **'Bus\nTimetable'**
  String get txtBusTimetable;

  /// No description provided for @txtShowTickets.
  ///
  /// In en, this message translates to:
  /// **'Show\nTickets'**
  String get txtShowTickets;

  /// No description provided for @txtPlaceHolder.
  ///
  /// In en, this message translates to:
  /// **'PlaceHolder'**
  String get txtPlaceHolder;

  /// No description provided for @txtChangeMyDetails.
  ///
  /// In en, this message translates to:
  /// **'Change My Details'**
  String get txtChangeMyDetails;

  /// No description provided for @txtCommunicationPreferences.
  ///
  /// In en, this message translates to:
  /// **'Communication Preferences'**
  String get txtCommunicationPreferences;

  /// No description provided for @txtClubAndMembership.
  ///
  /// In en, this message translates to:
  /// **'Club & Membership'**
  String get txtClubAndMembership;

  /// No description provided for @txtGamingPreferences.
  ///
  /// In en, this message translates to:
  /// **'Gaming Preferences'**
  String get txtGamingPreferences;

  /// No description provided for @txtPASStatement.
  ///
  /// In en, this message translates to:
  /// **'PAS Statement'**
  String get txtPASStatement;

  /// No description provided for @txtEditAccountDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Account Details'**
  String get txtEditAccountDetails;

  /// No description provided for @txtSponsorship.
  ///
  /// In en, this message translates to:
  /// **'Sponsorship'**
  String get txtSponsorship;

  /// No description provided for @txtClubSponsorship.
  ///
  /// In en, this message translates to:
  /// **'Club Sponsorship'**
  String get txtClubSponsorship;

  /// No description provided for @txtPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get txtPhoneNumber;

  /// No description provided for @txtAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get txtAddress;

  /// No description provided for @txtPostcode.
  ///
  /// In en, this message translates to:
  /// **'Postcode'**
  String get txtPostcode;

  /// No description provided for @txtBirthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get txtBirthday;

  /// No description provided for @txtFirstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get txtFirstName;

  /// No description provided for @txtFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get txtFullName;

  /// No description provided for @txtLastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get txtLastName;

  /// No description provided for @hintEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get hintEmail;

  /// No description provided for @txtMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get txtMale;

  /// No description provided for @txtFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get txtFemale;

  /// No description provided for @txtNonBinary.
  ///
  /// In en, this message translates to:
  /// **'Non-Binary'**
  String get txtNonBinary;

  /// No description provided for @txtJoinNow.
  ///
  /// In en, this message translates to:
  /// **'Join now'**
  String get txtJoinNow;

  /// No description provided for @txtMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get txtMobileNumber;

  /// No description provided for @txtRecoveryEmail.
  ///
  /// In en, this message translates to:
  /// **'Recovery Email'**
  String get txtRecoveryEmail;

  /// No description provided for @txtMyDetails.
  ///
  /// In en, this message translates to:
  /// **'My Details'**
  String get txtMyDetails;

  /// No description provided for @txtView.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get txtView;

  /// No description provided for @txtTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get txtTermsAndConditions;

  /// No description provided for @msgTermsAndConditionSignup.
  ///
  /// In en, this message translates to:
  /// **'By pressing the JOIN NOW button I agree to the terms and conditions of the Venue\'s Loyalty Program and I am at least 18 years of age.'**
  String get msgTermsAndConditionSignup;

  /// No description provided for @txtDeleteMyAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get txtDeleteMyAccount;

  /// No description provided for @txtViewTermsConditions.
  ///
  /// In en, this message translates to:
  /// **'View T&C\'s'**
  String get txtViewTermsConditions;

  /// No description provided for @txtMyProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get txtMyProfile;

  /// No description provided for @txtLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get txtLogout;

  /// No description provided for @txtCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get txtCancel;

  /// No description provided for @txtCancelAccount.
  ///
  /// In en, this message translates to:
  /// **'Cancel Account'**
  String get txtCancelAccount;

  /// No description provided for @txtMyDigitalCard.
  ///
  /// In en, this message translates to:
  /// **'My Digital Card   >'**
  String get txtMyDigitalCard;

  /// No description provided for @txtMyVenue.
  ///
  /// In en, this message translates to:
  /// **'My Venue'**
  String get txtMyVenue;

  /// No description provided for @txtMyCard.
  ///
  /// In en, this message translates to:
  /// **'My Card'**
  String get txtMyCard;

  /// No description provided for @txtMembership.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get txtMembership;

  /// No description provided for @txtMembershipBenefits.
  ///
  /// In en, this message translates to:
  /// **'Membership Benefits'**
  String get txtMembershipBenefits;

  /// No description provided for @txtEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get txtEmail;

  /// No description provided for @txtSMS.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get txtSMS;

  /// No description provided for @txtAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get txtAdd;

  /// No description provided for @txtClubCode.
  ///
  /// In en, this message translates to:
  /// **'Club Code'**
  String get txtClubCode;

  /// No description provided for @txtSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get txtSuccess;

  /// No description provided for @msgMobileNumberUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your new mobile number has been registered.'**
  String get msgMobileNumberUpdated;

  /// No description provided for @msgEmptyFirstName.
  ///
  /// In en, this message translates to:
  /// **'First name can\'t be empty'**
  String get msgEmptyFirstName;

  /// No description provided for @msgEmptyLastName.
  ///
  /// In en, this message translates to:
  /// **'Last name can\'t be empty'**
  String get msgEmptyLastName;

  /// No description provided for @msgEmptyAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid address to continue.'**
  String get msgEmptyAddress;

  /// No description provided for @msgEmptyEmail.
  ///
  /// In en, this message translates to:
  /// **'Email can\'t be empty'**
  String get msgEmptyEmail;

  /// No description provided for @msgIncorrectEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter correct email address'**
  String get msgIncorrectEmail;

  /// No description provided for @msgEmptyPostcode.
  ///
  /// In en, this message translates to:
  /// **'Postcode can\'t be empty'**
  String get msgEmptyPostcode;

  /// No description provided for @msgEmptyDay.
  ///
  /// In en, this message translates to:
  /// **'Day can\'t be empty'**
  String get msgEmptyDay;

  /// No description provided for @msgEmptyMonth.
  ///
  /// In en, this message translates to:
  /// **'Month can\'t be empty'**
  String get msgEmptyMonth;

  /// No description provided for @msgEmptyYear.
  ///
  /// In en, this message translates to:
  /// **'Year can\'t be empty'**
  String get msgEmptyYear;

  /// No description provided for @msgIncorrectOTP.
  ///
  /// In en, this message translates to:
  /// **'Please enter the correct 4-digit OTP to proceed.'**
  String get msgIncorrectOTP;

  /// No description provided for @msgSendingOTP.
  ///
  /// In en, this message translates to:
  /// **'Sending OTP on your phone...'**
  String get msgSendingOTP;

  /// No description provided for @msgResendOTP.
  ///
  /// In en, this message translates to:
  /// **'Sending again OTP on your phone...'**
  String get msgResendOTP;

  /// No description provided for @msgVerifyingOTP.
  ///
  /// In en, this message translates to:
  /// **'Verifying OTP...'**
  String get msgVerifyingOTP;

  /// No description provided for @msgPleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get msgPleaseWait;

  /// No description provided for @txtResendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code '**
  String get txtResendCode;

  /// No description provided for @msgVerificationIssue.
  ///
  /// In en, this message translates to:
  /// **'There was an issue verifying your account, please try again.'**
  String get msgVerificationIssue;

  /// No description provided for @msgOtpSent.
  ///
  /// In en, this message translates to:
  /// **'OTP has been sent successfully!'**
  String get msgOtpSent;

  /// No description provided for @msgEnterClubCode.
  ///
  /// In en, this message translates to:
  /// **'Enter your club code'**
  String get msgEnterClubCode;

  /// No description provided for @msgIncorrectFullName.
  ///
  /// In en, this message translates to:
  /// **'Kindly enter your full name in the format: First Name [space] Last Name.'**
  String get msgIncorrectFullName;

  /// No description provided for @loadermsgCancelAccount.
  ///
  /// In en, this message translates to:
  /// **'Please wait, while we are deleting your account.'**
  String get loadermsgCancelAccount;

  /// No description provided for @msgPleaseRegister.
  ///
  /// In en, this message translates to:
  /// **'Please register your account'**
  String get msgPleaseRegister;

  /// No description provided for @msgFillDetailsForSignup.
  ///
  /// In en, this message translates to:
  /// **'Fill in the details below to sign up'**
  String get msgFillDetailsForSignup;

  /// No description provided for @msgIncorrectPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'The provided phone number is incorrect. Please double-check and re-enter it.'**
  String get msgIncorrectPhoneNumber;

  /// No description provided for @msgCheckTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'To proceed, please tick the checkbox indicating your agreement to the Terms & Conditions.'**
  String get msgCheckTermsAndConditions;

  /// No description provided for @msgSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please choose your gender from the options provided.'**
  String get msgSelectGender;

  /// No description provided for @msgIncorrectDOB.
  ///
  /// In en, this message translates to:
  /// **'Ensure that your date of birth is entered correctly. You must be at least 18 years of age to proceed.'**
  String get msgIncorrectDOB;

  /// No description provided for @msgCommonError.
  ///
  /// In en, this message translates to:
  /// **'Ooppss.. something went wrong, please try again.'**
  String get msgCommonError;

  /// No description provided for @msgCommonUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request processed successfully!!'**
  String get msgCommonUpdateSuccess;

  /// No description provided for @msgCommonLoader.
  ///
  /// In en, this message translates to:
  /// **'Please wait, while we are processing your request.'**
  String get msgCommonLoader;

  /// No description provided for @txtCommunicationChannel.
  ///
  /// In en, this message translates to:
  /// **'Communication Channels'**
  String get txtCommunicationChannel;

  /// No description provided for @txtValidTo.
  ///
  /// In en, this message translates to:
  /// **'Valid to'**
  String get txtValidTo;

  /// No description provided for @txtStatusCreditsReactNextLevel.
  ///
  /// In en, this message translates to:
  /// **'Status Credits to reach next level'**
  String get txtStatusCreditsReactNextLevel;

  /// No description provided for @txtEditMyDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit my details'**
  String get txtEditMyDetails;

  /// No description provided for @txtEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get txtEdit;

  /// No description provided for @txtEntries.
  ///
  /// In en, this message translates to:
  /// **'Entries'**
  String get txtEntries;

  /// No description provided for @txtAlert.
  ///
  /// In en, this message translates to:
  /// **'Alert!'**
  String get txtAlert;

  /// No description provided for @txtYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get txtYes;

  /// No description provided for @txtNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get txtNo;

  /// No description provided for @msgLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out of the application?'**
  String get msgLogout;

  /// No description provided for @msgCancelAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?\nOnce you confirm, this account will no longer be able to be used and your data and personal information will be removed from our system permanently within 48 hours.'**
  String get msgCancelAccount;

  /// No description provided for @txtPlayerActivityStatementFor.
  ///
  /// In en, this message translates to:
  /// **'Player Activity Statement for'**
  String get txtPlayerActivityStatementFor;

  /// No description provided for @txtDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get txtDetails;

  /// No description provided for @txtTotalAmountBet.
  ///
  /// In en, this message translates to:
  /// **'Total Amount Bet'**
  String get txtTotalAmountBet;

  /// No description provided for @txtTotalAmountWon.
  ///
  /// In en, this message translates to:
  /// **'Total Amount Won'**
  String get txtTotalAmountWon;

  /// No description provided for @txtNetAmountWonOrLost.
  ///
  /// In en, this message translates to:
  /// **'Net Amount Won or Lost'**
  String get txtNetAmountWonOrLost;

  /// No description provided for @txtTotalDaysPlayed.
  ///
  /// In en, this message translates to:
  /// **'Total Days Played'**
  String get txtTotalDaysPlayed;

  /// No description provided for @txtTotalHoursPlayed.
  ///
  /// In en, this message translates to:
  /// **'Total Hours Played'**
  String get txtTotalHoursPlayed;

  /// No description provided for @txtPerformance.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get txtPerformance;

  /// No description provided for @txtTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get txtTo;

  /// No description provided for @msgProfileUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your profile has been updated successfully!'**
  String get msgProfileUpdateSuccess;

  /// No description provided for @msgProfileUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Oops... something went wrong while updating your profile.'**
  String get msgProfileUpdateError;

  /// No description provided for @msgProfileUpdateLoading.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we update your profile...'**
  String get msgProfileUpdateLoading;

  /// No description provided for @msgOtpIssue.
  ///
  /// In en, this message translates to:
  /// **'There was a problem sending the OTP. Please try again.'**
  String get msgOtpIssue;

  /// No description provided for @msgVerificationCodeSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification code to your email address.'**
  String get msgVerificationCodeSentToEmail;

  /// No description provided for @msgVerificationCodeSentToPhone.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification code to the mobile number ending in'**
  String get msgVerificationCodeSentToPhone;

  /// No description provided for @msgIssueInVerifyAccount.
  ///
  /// In en, this message translates to:
  /// **'There was a problem verifying your account. Please try again.'**
  String get msgIssueInVerifyAccount;

  /// No description provided for @msgEnterNewMobile.
  ///
  /// In en, this message translates to:
  /// **'Please enter your new mobile number'**
  String get msgEnterNewMobile;

  /// No description provided for @msgClubCodeSaved.
  ///
  /// In en, this message translates to:
  /// **'Club code has been saved successfully!'**
  String get msgClubCodeSaved;

  /// No description provided for @takePhotoOf.
  ///
  /// In en, this message translates to:
  /// **'Take a photo of'**
  String get takePhotoOf;

  /// No description provided for @frontOfDL.
  ///
  /// In en, this message translates to:
  /// **'Front of Driver\'s Licence'**
  String get frontOfDL;

  /// No description provided for @ensureFits.
  ///
  /// In en, this message translates to:
  /// **'Ensure your licence fits within the white guidelines'**
  String get ensureFits;

  /// No description provided for @takePhotoBtn.
  ///
  /// In en, this message translates to:
  /// **'TAKE PHOTO'**
  String get takePhotoBtn;

  /// No description provided for @retakeBtn.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get retakeBtn;

  /// No description provided for @backOfDL.
  ///
  /// In en, this message translates to:
  /// **'Back of Driver\'s Licence'**
  String get backOfDL;

  /// No description provided for @fetchingCameras.
  ///
  /// In en, this message translates to:
  /// **'Fetching cameras..\nIf you haven’t granted Camera or Microphone permissions'**
  String get fetchingCameras;

  /// No description provided for @openAppSettings.
  ///
  /// In en, this message translates to:
  /// **'tap here to open App Settings'**
  String get openAppSettings;

  /// No description provided for @registerToContinue.
  ///
  /// In en, this message translates to:
  /// **'Register to continue'**
  String get registerToContinue;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @noLicense.
  ///
  /// In en, this message translates to:
  /// **'I don\'t have a licence'**
  String get noLicense;

  /// No description provided for @chooseYourMembership.
  ///
  /// In en, this message translates to:
  /// **'Choose your membership'**
  String get chooseYourMembership;

  /// No description provided for @selectMembership.
  ///
  /// In en, this message translates to:
  /// **'Select membership'**
  String get selectMembership;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @membershipRequiresApproval.
  ///
  /// In en, this message translates to:
  /// **'Membership requires approval and confirmation from the Club.'**
  String get membershipRequiresApproval;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm payment'**
  String get confirmPayment;

  /// No description provided for @selectMembershipPlan.
  ///
  /// In en, this message translates to:
  /// **'Please select a membership plan to move to next step'**
  String get selectMembershipPlan;

  /// No description provided for @fetchingMembershipPlan.
  ///
  /// In en, this message translates to:
  /// **'Please wait, while we are fetching membership plans for you'**
  String get fetchingMembershipPlan;

  /// No description provided for @verifyingPayment.
  ///
  /// In en, this message translates to:
  /// **'Please wait, while we are verifying your payment'**
  String get verifyingPayment;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @activateMessage.
  ///
  /// In en, this message translates to:
  /// **'PLEASE PAY AT RECEPTION\n\nor\n\nSkip the queue and pay by card now'**
  String get activateMessage;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// No description provided for @waitingPayment.
  ///
  /// In en, this message translates to:
  /// **'Waiting for payment'**
  String get waitingPayment;

  /// No description provided for @payReception.
  ///
  /// In en, this message translates to:
  /// **'PAY AT RECEPTION'**
  String get payReception;

  /// No description provided for @payByCard.
  ///
  /// In en, this message translates to:
  /// **'Pay by card'**
  String get payByCard;

  /// No description provided for @paymentUnsuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment unsuccessful'**
  String get paymentUnsuccessful;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @receptionPaymentMessage.
  ///
  /// In en, this message translates to:
  /// **'Your details have been sent to reception. Please see one of our friendly staff members to complete payment.\n\nYou can pay via cash or card.'**
  String get receptionPaymentMessage;

  /// No description provided for @payAtReception.
  ///
  /// In en, this message translates to:
  /// **'Please pay at reception'**
  String get payAtReception;

  /// No description provided for @membership_unavailable_title.
  ///
  /// In en, this message translates to:
  /// **'MEMBERSHIP\nNO LONGER\nAVAILABLE'**
  String get membership_unavailable_title;

  /// No description provided for @contact_to_venue_text.
  ///
  /// In en, this message translates to:
  /// **'Please get in touch with your venue to discuss.'**
  String get contact_to_venue_text;

  /// No description provided for @pleaseTakeSelfie.
  ///
  /// In en, this message translates to:
  /// **'Please take a selfie'**
  String get pleaseTakeSelfie;

  /// No description provided for @faceInWhiteFrame.
  ///
  /// In en, this message translates to:
  /// **'Make sure your face is in the white frame and is clearly visible'**
  String get faceInWhiteFrame;

  /// No description provided for @uploadingSelfie.
  ///
  /// In en, this message translates to:
  /// **'Please wait, while we are uploading your picture'**
  String get uploadingSelfie;

  /// No description provided for @logoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Just a moment, we’re logging you out.'**
  String get logoutMessage;

  /// No description provided for @msgForOtherMembershipSeeReception.
  ///
  /// In en, this message translates to:
  /// **'For all other memberships\n\nPlease see reception.'**
  String get msgForOtherMembershipSeeReception;

  /// No description provided for @msgPaymentCancelled.
  ///
  /// In en, this message translates to:
  /// **'The payment has been cancelled.'**
  String get msgPaymentCancelled;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// No description provided for @msgNoInternet.
  ///
  /// In en, this message translates to:
  /// **'You are not connected to the internet\nCheck your connection and try again.'**
  String get msgNoInternet;

  /// No description provided for @msgNoOffers.
  ///
  /// In en, this message translates to:
  /// **'No offers found!'**
  String get msgNoOffers;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh': {
  switch (locale.countryCode) {
    case 'CN': return AppLocalizationsZhCn();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
