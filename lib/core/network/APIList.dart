class APIList {
  // SANDBOX
 // static get BASE_URL => "https://betaapi.s2w.com.au/";

  // LIVE
  static get BASE_URL => "http://3.24.55.180:8081/";
  // static get BASE_URL => "https://api.s2w.com.au/";

  static get LOGIN => BASE_URL + "user/check/";

  static get REGISTRATION => BASE_URL + "user/register/";

  // static get VERIFY_OTP => BASE_URL + "user/verify-otp";
  static get VERIFY_OTP => BASE_URL + "user/verify-otp-demo";

  static get GET_POINTS => BASE_URL + "user/get-points";

  static get GET_PROFILE => BASE_URL + "user/get-profile";

  static get UPDATE_USER_INFO => BASE_URL + "user/update-profile";

  static get SEND_OTP_PROFILE => BASE_URL + "user/otp-generate";

  static get RESEND_OTP_PROFILE => BASE_URL + "user/otp-again";

  static get VERIFY_OTP_PROFILE => BASE_URL + "user/profile-verify";

  static get UPLOAD_DEVICE_TOKEN => BASE_URL + "user/device-token";

  static get CANCEL_ACCOUNT => BASE_URL + "user/cancel";

  static get SEND_OTP_NEW_NUMBER => BASE_URL + "user/otp-newNumber";

  static get RESEND_OTP_NEW_NUMBER => BASE_URL + "user/otp-newNumber/resent/";

  static get VERIFY_OTP_NEW_NUMBER => BASE_URL + "user/otp-newNumber/verify";

  static get SEND_OTP_EMAIL => BASE_URL + "user/otp-email";

  static get RESEND_OTP_EMAIL => BASE_URL + "user/otp-again-email/";

  static get VERIFY_OTP_EMAIL => BASE_URL + "user/otp-verify-email/";

  static get FETCH_PROMOTIONS => BASE_URL + "promotion/getBycategory?category=";

  static get FETCH_SPECIAL_OFFERS_FILTERS => BASE_URL + "offer/button/get";

  static get FETCH_VOUCHERS => BASE_URL + "offer/getbyrating?ratingLevel=";

  static get FETCH_VOUCHER_BY_ID => BASE_URL + "offer/getByIdMobile/";

  static get UPDATE_DEVICE_DETAILS => BASE_URL + "user/device-details";

  static get CHECK_APP_UPDATE => BASE_URL + "user/checkUpdate";

  static get GET_USERS_BENEFITS => BASE_URL + "benefits/getBenefitsForApp?";

  static get FETCH_HOME_BUTTONS => BASE_URL + "button/get";

  static get UPDATE_COUPON_CODE => BASE_URL + "user/coupon-update";

  static get UPLOAD_DRIVING_LICENSE_IMAGES => BASE_URL + "images/upload";

  static get FETCH_MEMBERSHIP_PLAN => BASE_URL + "club-package/club?";

  static get UPLOAD_PROFILE_PIC => BASE_URL + "user/";

  static get LOGOUT => BASE_URL + "user/logout";

  //https://betaapi.s2w.com.au/club-package/club?appType=Qantum&timezone=Asia/Kolkata

  /// STRIPE APIS ///
  static get CREATE_PAYMENT_INTENT =>
      BASE_URL + "payment/create-payment-intent";

  static get VERIFY_PAYMENT => BASE_URL + "payment/verify-payment";

  static get UPDATE_PAYMENT_TYPE => BASE_URL + "user/payment-update";

  ///  VENKAT'S API ///
  static get SCAN_DRIVING_LICENSE_IMAGES =>
      "https://licensedataextractorapp.blackfield-3f4ad4c0.australiaeast.azurecontainerapps.io/licensedataextract";

  /// TERMS AND CONDITIONS URL ///
//  static get TERMS_AND_CONDITIONS => "https://terms-conditions.com.au/q_app/";
  static get TERMS_AND_CONDITIONS => "https://terms-conditions.com.au/star-rewards-loyalty/";


}
