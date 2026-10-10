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
  pod 'QCloudCOSXML/Transfer'
  
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

  # 修复 QCloudSimplePing 在 Xcode 26 上的 sa_family_t 模块错误
  # 创建 prefix header 强制导入 Darwin 模块
  qcloud_prefix = installer.sandbox.root + 'QCloudPrefixHeader.pch'
  File.write(qcloud_prefix, "@import Darwin.POSIX.sys.types._sa_family_t;\n")
  installer.pods_project.targets.each do |target|
    next unless target.name == 'QCloudCore'
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREFIX_HEADER'] = qcloud_prefix.to_s
      config.build_settings['GCC_PRECOMPILE_PREFIX_HEADER'] = 'YES'
    end
  end
  puts "✅ QCloudCore prefix header set for sa_family_t"

  # 修复 SVProgressHUD 在 iOS 27 上提示信息跑到左上角的问题
  sv_path = installer.sandbox.pod_dir('SVProgressHUD').to_s + '/SVProgressHUD/SVProgressHUD.m'
  if File.exist?(sv_path)
    c = File.read(sv_path)
    # 替换 frontWindow 方法
    c.gsub!(/- \(UIWindow \*\)frontWindow \{.*?\n\}/m) do |old|
      "- (UIWindow *)frontWindow {\n#if !defined(SV_APP_EXTENSIONS)\n    for (UIScene *scene in [UIApplication.sharedApplication.connectedScenes allObjects]) {\n        if (scene.activationState != UISceneActivationStateForegroundActive) continue;\n        if (![scene isKindOfClass:[UIWindowScene class]]) continue;\n        UIWindowScene *windowScene = (UIWindowScene *)scene;\n        for (UIWindow *window in windowScene.windows) {\n            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;\n            BOOL windowIsVisible = !window.hidden && window.alpha > 0;\n            BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= self.maxSupportedWindowLevel);\n            if(windowOnMainScreen && windowIsVisible && windowLevelSupported) {\n                return window;\n            }\n        }\n    }\n#endif\n    return nil;\n}"
    end
    # 替换 keyWindow 调用
    c.gsub!('[UIApplication sharedApplication].keyWindow.bounds', '[self frontWindow].bounds')
    c.gsub!('[[UIApplication sharedApplication] keyWindow].rootViewController', '[self frontWindow].rootViewController')
    File.write(sv_path, c)
    puts "✅ SVProgressHUD patched for iOS 27"
  end
end
