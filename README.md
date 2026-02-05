# qantum_apps

### FLUTTERFIRE CLI COMMAND TO CREATE PROJECT IN APP
### REFERENCE LINK: https://codewithandrea.com/articles/flutter-firebase-multiple-flavors-flutterfire-cli/
### COMMAND: flutterfire config --project=flutter-ship-dev --out=lib/firebase_options_dev.dart --ios-bundle-id=com.codewithandrea.flutterShipApp.dev --ios-out=ios/flavors/dev/GoogleService-Info.plist --android-package-name=com.codewithandrea.flutter_ship_app.dev --android-out=android/app/src/dev/google-services.json

### FOR GENERATING APPLOCALIZATIONS
### COMMAND: flutter gen-l10n


### STAR REWARD APP
### COMMAND TO RUN THE APP : flutter run apk --flavor starReward -t lib/main_sr.dart
### COMMAND TO BUILD THE APP : flutter run apk --release --flavor starReward -t lib/main_sr.dart


### QANTUM APP
### COMMAND TO RUN THE APP : flutter run apk --flavor qantum -t lib/main_qa.dart
### COMMAND TO BUILD THE APP : flutter run apk --release --flavor qantum -t lib/main_qa.dart

### MAX GAMING APP
### COMMAND TO RUN THE APP : flutter run apk --flavor maxx -t lib/main_max.dart
### COMMAND TO BUILD THE APP : flutter build apk --release --flavor maxx -t lib/main_max.dart

### COMMAND FOR TEST THE DEEP LINK
adb shell am start \                                    
-a android.intent.action.VIEW \
-d "https://betaapi.s2w.com.au"

### Kingscliff app build ios
### flutter build ipa --release --flavor kingscliff -t lib/main_kc.dart
