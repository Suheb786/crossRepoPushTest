cd /Users/neosoft/StudioProjects/neobank/lib || exit
fvm flutter clean
fvm flutter pub get
cd /Users/neosoft/StudioProjects/neobank/ios || exit
#pod repo update
pod install
#fvm flutter run -release
#flutter build appbundle --release --no-tree-shake-icons
