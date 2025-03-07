class APIList {
  static get BASE_URL => "http://13.239.30.205:8081/";

  // LOCAL HOST static get BASE_URL => "http://10.0.2.2:8081/";

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

  static get FETCH_VOUCHERS => BASE_URL + "voucher/getbyrating?ratingLevel=";

  static get FETCH_VOUCHER_BY_ID => BASE_URL + "voucher/getByIdMobile/";

  static get UPDATE_DEVICE_DETAILS => BASE_URL + "user/device-details";
}
