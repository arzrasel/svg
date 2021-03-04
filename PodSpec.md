# CREATE

* pod lib create AlamofireKit
* ios>swift>yes>None>No
* Push to git and release
* pod trunk register rashed@rasel.com 'Rz Rasel'
* pod lib lint AlamofireKit.podspec --allow-warnings <<ORRR>> pod lib lint AlamofireKit.podspec --allow-warnings --no-clean --verbose
* pod trunk push --allow-warnings

# UPDATE

* pod lib lint --allow-warnings <<ORRR>> pod lib lint --allow-warnings --no-clean --verbose
* Push to git and release
* pod trunk push --allow-warnings <<ORRR>> pod trunk push AlamofireKit.podspec --allow-warnings
