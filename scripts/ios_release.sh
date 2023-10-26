cd /Users/neosoft/StudioProjects/neobank/lib || exit
fvm flutter clean
fvm flutter pub get
cd /Users/neosoft/StudioProjects/neobank/ios || exit
fvm flutter precache --ios
pod repo update
pod install
pod update
#flutter build appbundle --release --no-tree-shake-icons
