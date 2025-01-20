class APIList {
  static get BASE_URL => "http://13.239.30.205:8081/";

  // LOCAL HOST static get BASE_URL => "http://10.0.2.2:8081/";

  static get LOGIN => BASE_URL + "user/check/";

  static get REGISTRATION => BASE_URL + "user/register/";

  static get VERIFY_OTP => BASE_URL + "user/verify-otp";

  static get GET_POINTS => BASE_URL + "user/get-points";

  static get GET_PROFILE => BASE_URL + "user/get-profile";

  static get UPDATE_USER_INFO => BASE_URL + "user/update-profile";

  static get SEND_OTP_PROFILE => BASE_URL + "user/otp-generate";

  static get RESEND_OTP_PROFILE => BASE_URL + "user/otp-again";

  static get VERIFY_OTP_PROFILE => BASE_URL + "user/profile-verify";

  static get UPLOAD_DEVICE_TOKEN => BASE_URL + "user/device-token";

  static get CANCEL_ACCOUNT => BASE_URL + "user/cancel";


}
