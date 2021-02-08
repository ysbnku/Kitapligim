# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Kitapligim' do

pod 'Alamofire-SwiftyJSON', '~> 3.0'
pod 'AlamofireObjectMapper', '5.2.1'
pod 'QRScanner'
pod 'Firebase'
pod 'FBSDKCoreKit'
pod 'FBSDKLoginKit'
pod 'FBSDKShareKit'
pod 'GoogleSignIn'

platform :ios, '10.0'
use_frameworks!
pod 'SDWebImage'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
    end
end
