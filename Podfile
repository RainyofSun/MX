platform :ios, '14.0'

source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

# 定义公共库
def CommonPods
  pod 'CocoaLumberjack', '3.8.5'
  pod 'Toast', '4.1.1'
  pod 'DZNEmptyDataSet', '1.8.1'
  pod 'FDFullscreenPopGesture', '1.1'
  pod 'Reachability', '3.2'
  pod 'TZImagePickerController', '3.8.8'
  pod 'YYKit', '1.0.9'
  pod 'Masonry', '1.1.0'
  pod 'MJRefresh', '3.7.9'
  pod 'AFNetworking', '4.0.1'
  pod 'IQKeyboardManager', '6.5.19'
end

def HostPods
  pod "GSCaptchaButton", '1.0.1'
  pod 'BRPickerView/Default','2.9.1'
  pod 'LJContactManager', '1.0.7'
  pod 'FBSDKCoreKit', '17.4.0'
end

target 'MXCash' do
  CommonPods()
  HostPods()
end

post_install do |installer|
  
  installer.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
  
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    config.build_settings['CODE_SIGN_IDENTITY'] = ''
  end
end
