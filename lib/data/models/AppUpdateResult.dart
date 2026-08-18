class AppUpdateResult {
  final bool shouldShowDialog;
  final bool forceUpdate;
  final String message;
  final String storeUrl;
  final String latestVersion;
  final int latestBuild;

  const AppUpdateResult({
    required this.shouldShowDialog,
    required this.forceUpdate,
    required this.message,
    required this.storeUrl,
    required this.latestVersion,
    required this.latestBuild,
  });

  factory AppUpdateResult.noUpdate() {
    return const AppUpdateResult(
      shouldShowDialog: false,
      forceUpdate: false,
      message: '',
      storeUrl: '',
      latestVersion: '',
      latestBuild: 0,
    );
  }
}