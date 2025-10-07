import '../models/NetworkResponse.dart';

abstract class AppDataRepository {
  Future<NetworkResponse> fetchPromotions(String membershipType);

  Future<NetworkResponse> fetchSpecialOffers(
      {required String membershipType,
      required String birthdayMonth,
      required String userId,
      required String joinDate,
      required String timezone});

  Future<NetworkResponse> fetchOfferByID(
      {required String offerID, required String userID});

  Future<NetworkResponse> fetchPartnerOffers();

  Future<NetworkResponse> fetchSeeAllButtons();

  Future<NetworkResponse> fetchDLInformation(
      {required String frontImagePath, required String backImagePath});

  Future<NetworkResponse> updateCouponCode({required String couponCode});
}
