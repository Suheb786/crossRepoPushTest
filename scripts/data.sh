cd /Users/neosoft/StudioProjects/neobank/data || exit
fvm flutter clean
fvm flutter pub get ; fvm dart pub run build_runner build --delete-conflicting-outputs