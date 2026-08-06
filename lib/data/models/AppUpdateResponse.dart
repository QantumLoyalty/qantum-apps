class AppUpdateResponse
{
  final bool success;
  final AppUpdateData? data;

  const AppUpdateResponse({
    required this.success,
    this.data,
  });

  factory AppUpdateResponse.fromJson(Map<String, dynamic> json) {
    return AppUpdateResponse(
      success: json['success'] == true,
      data: json['data'] is Map<String, dynamic>
          ? AppUpdateData.fromJson(
        json['data'] as Map<String, dynamic>,
      )
          : null,
    );
  }

}

class AppUpdateData {
  final PlatformUpdateInfo? android;
  final PlatformUpdateInfo? ios;
  final String? message;

  const AppUpdateData({
    this.android,
    this.ios,
    this.message,
  });

  factory AppUpdateData.fromJson(Map<String, dynamic> json) {
    return AppUpdateData(
      android: json['android'] is Map<String, dynamic>
          ? PlatformUpdateInfo.fromJson(
        json['android'] as Map<String, dynamic>,
      )
          : null,
      ios: json['ios'] is Map<String, dynamic>
          ? PlatformUpdateInfo.fromJson(
        json['ios'] as Map<String, dynamic>,
      )
          : null,
      message: json['message']?.toString(),
    );
  }
}




class PlatformUpdateInfo {
  final String? latestVersion;
  final int? latestBuild;
  final bool forceUpdate;
  final String? storeUrl;

  const PlatformUpdateInfo({
    this.latestVersion,
    this.latestBuild,
    required this.forceUpdate,
    this.storeUrl,
  });

  factory PlatformUpdateInfo.fromJson(Map<String, dynamic> json) {
    return PlatformUpdateInfo(
      latestVersion: json['latest_version']?.toString(),
      latestBuild: _parseInt(json['latest_build']),
      forceUpdate: json['force_update'] == true,
      storeUrl: json['store_url']?.toString(),
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}