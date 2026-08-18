
class SmartIncentivesParam {
  final String id;
  final List<String> audience;

  SmartIncentivesParam({
    required this.id,
    required this.audience,
  });

  // Converts the Dart object into a Map structure
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'audience': audience,
    };
  }

  @override
  String toString() {
    return 'SmartIncentivesParam{id: $id, audience: $audience}';
  }
}
