Pod::Spec.new do |s|
  s.name         = "ShadowPath"
  s.version      = "0.1.0"
  s.summary      = "Http and Socks proxy based on Privoxy and Antinat"
  s.description  = <<-DESC
                   Http and Socks proxy based on Privoxy and Antinat.
                   DESC
  s.homepage     = "http://icodesign.me"
  s.license      = "GPLv2"
  s.author        = { "iCodesign" => "leimagnet@gmail.com" }
  s.source           = { :git => 'git@github.com', :tag => s.version.to_s }
  s.ios.deployment_target = '10.2'
  s.osx.deployment_target = '10.9'
  s.source_files  = "ShadowPath/ShadowPath.h"


  s.subspec 'libmaxminddb' do |minddb|
    minddb.header_mappings_dir = 'ShadowPath/libmaxminddb/include'
    minddb.source_files =  "ShadowPath/libmaxminddb/include/*.{c,h}",
    "ShadowPath/libmaxminddb/src/*.{c,h,m}"
    minddb.xcconfig = {  
      'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/../Library/ShadowPath/ShadowPath/libmaxminddb/include ${PODS_ROOT}/ShadowSocks-libev-iOS/ShadowSocks-libev-iOS/shadowsocks-libev',
    }
  end

  s.subspec 'Antinat' do |nat|
    nat.header_mappings_dir = 'ShadowPath/Antinat'
    nat.source_files = "ShadowPath/Antinat/**/*.{c,h,m}"
    nat.public_header_files = "ShadowPath/Antinat/server/AntinatServer.h"
    nat.xcconfig = {  
      'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/../Library/ShadowPath/ShadowPath/Antinat',
    }
  end
  s.subspec 'Privoxy' do |privoxy|
    privoxy.header_mappings_dir = 'ShadowPath/Privoxy'
    privoxy.source_files = "ShadowPath/Privoxy/*.{c,h,m}"
    #privoxy.private_header_files = "ShadowPath/Privoxy/*.h"
    privoxy.public_header_files = "ShadowPath/Privoxy/jcc.h",
    "ShadowPath/Privoxy/project.h"
    privoxy.xcconfig = {  
     'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/../Library/ShadowPath/ShadowPath/Privoxy',
    }
  end

  s.public_header_files = "ShadowPath/ShadowPath.h" 
  s.library = "z"
  s.pod_target_xcconfig = { 
    'OTHER_CFLAGS' => '-DHAVE_CONFIG_H -DLIB_ONLY -DUDPRELAY_LOCAL -DMODULE_LOCAL', 
    # 'HEADER_SEARCH_PATHS' => '',
  }
  s.vendored_libraries = 'ShadowPath/Antinat/expat-lib/lib/libexpat.a'
  s.dependency 'ShadowSocks-libev-iOS', '~> 3.2.5'
  s.libraries='expat'
end
