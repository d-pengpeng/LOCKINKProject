# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

# source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'


target 'BlueEquipProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

#  pod 'LFImagePickerController'
  pod 'AFNetworking'
  pod 'SVProgressHUD'
  pod 'SDCycleScrollView'
  pod 'Masonry'
  pod 'MJRefresh'
  pod 'SVGAPlayer'
  pod 'MJExtension'
  pod "Qiniu"
  pod 'JPush'  # 4.8.1 , '~> 4.8.1'
  pod 'MBProgressHUD'
  pod 'BRPickerView' #2.9.3
  pod 'SocketRocket'
  pod 'Bugly'
  pod 'QCloudCOSXML/Transfer', '~> 6.5.7'
  
  # Pods for BlueEquipProject

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
      config.build_settings.delete('PROVISIONING_PROFILE')
      config.build_settings.delete('PROVISIONING_PROFILE_SPECIFIER')
      config.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
      config.build_settings['OTHER_CFLAGS'] = '$(inherited) -Wno-error=implicit-function-declaration -Wno-error=non-modular-include-in-framework-module -Wno-error=deprecated-objc-isa-usage'
    end
  end

end
