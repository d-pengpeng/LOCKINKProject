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
  pod 'JPush'  
  pod 'MBProgressHUD'
  pod 'BRPickerView' 
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

  # 关闭老 OC Pod 的模块校验（Xcode 26 严格模块校验）
  disable_module_targets = ['QCloudCore', 'AFNetworking', 'Qiniu']
  installer.pods_project.targets.each do |target|
    next unless disable_module_targets.include?(target.name)
    target.build_configurations.each do |config|
      config.build_settings['CLANG_ENABLE_MODULES'] = 'NO'
      config.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
      # 关闭 modules 后需显式链接系统框架
      config.build_settings['OTHER_LDFLAGS'] = '$(inherited) -framework Foundation -framework UIKit -framework CoreGraphics -framework Security -framework SystemConfiguration -framework MobileCoreServices -framework CFNetwork'
    end
  end
  puts "✅ Disabled CLANG_ENABLE_MODULES for: #{disable_module_targets.join(', ')}"

  # 补丁：QCloudSimplePing.h 替换 @import 为 #import，并添加 sys/socket.h
  ping_h = installer.sandbox.pod_dir('QCloudCore').to_s + '/QCloudCore/Classes/Base/QCLOUDRestNet/DNSCache/QCloudSimplePing.h'
  if File.exist?(ping_h)
    c = File.read(ping_h)
    c.sub!('@import Foundation;', '#import <Foundation/Foundation.h>')
    c.sub!('#import <sys/_types/_sa_family_t.h>', '#import <sys/socket.h>') unless c.include?('#import <sys/socket.h>')
    unless c.include?('#import <sys/socket.h>')
      c = "#import <sys/socket.h>\n" + c
    end
    File.write(ping_h, c)
    puts "✅ QCloudSimplePing.h patched (@import → #import, +sys/socket.h)"
  else
    puts "⚠️ QCloudSimplePing.h not found"
  end

  # 补丁：AFNetworking netinet6/in6.h 私有头文件
  afn_path = installer.sandbox.pod_dir('AFNetworking').to_s + '/AFNetworking/AFNetworkReachabilityManager.m'
  if File.exist?(afn_path)
    c = File.read(afn_path)
    c.sub!('#import <netinet6/in6.h>', '#import <netinet/in.h>')
    File.write(afn_path, c)
    puts "✅ AFNetworking patched (netinet6/in6.h → netinet/in.h)"
  end

end
