Pod::Spec.new do |s|
  s.name             = 'XYJSON'
  s.version          = '1.1.0'
  s.summary          = 'An easy way to create parameters of request.'

  s.homepage         = 'https://github.com/RayJiang16/XYJSON'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RayJiang' => '1184731421@qq.com' }
  s.source           = { :git => 'https://github.com/RayJiang16/XYJSON.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '5.1'

  s.source_files = 'Sources/Core/**/*.swift'

  s.frameworks = 'UIKit'

end
