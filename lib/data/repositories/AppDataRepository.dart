import '../models/NetworkResponse.dart';

abstract class AppDataRepository {

  Future<NetworkResponse> fetchPromotions(String membershipType);

  Future<NetworkResponse> fetchSpecialOffers({required String membershipType, required String birthdayMonth, required String userId, required String joinDate});
  Future<NetworkResponse> fetchOfferByID({required String offerID,required String userID});

  Future<NetworkResponse> fetchPartnerOffers();
}
