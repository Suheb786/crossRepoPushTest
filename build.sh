 cd /Users/apple/Documents/Dhaiyur/neobank/domain || exit
 fvm flutter clean
 fvm flutter pub get
 cd ..
 cd data || exit
 fvm flutter clean
 fvm flutter pub get
 fvm flutter pub run build_runner build --delete-conflicting-outputs
 cd ..
 cd infobip_rtc_flutter || exit
 fvm flutter clean
 fvm flutter pub get
 cd ..
 fvm flutter clean
 fvm flutter pub get
 fvm flutter run --debug
# fvm flutter build apk --release



