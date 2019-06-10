source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.3'
use_frameworks!
inhibit_all_warnings!


def model
  pod 'RealmSwift'
end

def socket
pod 'CocoaAsyncSocket', '~> 7.4.3'
end

def shadowsocks
  pod 'ShadowPath', :path => './Library/ShadowPath/'
  pod 'ShadowSocks-libev-iOS', :git => 'https://github.com/juvham/ShadowSocks-libev-iOS.git', :tag => '3.2.5.6.pre'
end

def library
  pod 'KissXML', '~> 5.2.3'
  pod 'MMWormhole', '~> 2.0.0'
  pod 'YAML-Framework', :spec => "./Library/YAML/YAML-Framework.spec" , :path=> "./Library/YAML/"
  model
end

def tunnel
  socket
  shadowsocks
  pod 'MMWormhole', '~> 2.0.0'
end

def client
  shadowsocks
  library
  pod 'AsyncSwift'
  pod 'ICSMainFramework', :path => "./Library/ICSMainFramework/"
  pod 'CocoaLumberjack/Swift', '~> 3.5.3'
  pod 'LogglyLogger-CocoaLumberjack', '~> 3.0'
  pod 'KeychainAccess'
  pod 'PSOperations/Core', '~> 4.0'

  
end

def app
  client
  pod 'Alamofire'
  pod 'SwiftColor'
  pod 'MBProgressHUD'
  pod 'ObjectMapper', '~> 3.4.2'
  pod 'ISO8601DateFormatter', '~> 0.8'
  pod 'Appirater'
  pod 'Cartography'
  pod 'Eureka'
  pod 'CallbackURLKit'
  pod 'ICDMaterialActivityIndicatorView',:git => 'https://github.com/icodesign/ICDMaterialActivityIndicatorView.git'
  pod 'PullToRefresher', '~> 3.1'
end

def today
  pod 'Cartography'
  pod 'SwiftColor'
  library
  socket
  model
end


#framework
target "PotatsoModel" do
  model
end

target "PacketProcessor" do
  socket
end

target "PotatsoLibrary" do
  library
end
#最小客户端
target "PotatsoClient" do
  client
end
#//各个目标文件
target "PacketTunnel" do
  tunnel
end
target "TodayWidget" do
  today
end


target "Potatso" do
  app
end








post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
             config.build_settings['ENABLE_BITCODE'] = 'NO'
#             if target.name == "CocoaLumberjack"
#                config.build_settings["GCC_PREPROCESSOR_DEFINITIONS"] = '$(inherited) DDDefaultLogLevel=1'
#             end
        end
    end
end
