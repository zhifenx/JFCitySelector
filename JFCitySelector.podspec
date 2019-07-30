Pod::Spec.new do |s|
s.name             = 'JFCitySelector'
s.version          = '0.0.1'
s.summary          = '城市选择器'

s.description      = <<-DESC
                    城市选择器 2019.7.30
DESC

s.homepage         = 'https://github.com/zhifenx'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'zhifenx' => 'zhifenx@163.com' }
s.source           = { :git => 'https://github.com/zhifenx/JFCitySelector.git', :tag => s.version.to_s }

s.platform     = :ios
s.ios.deployment_target = '10.0'
s.swift_versions = '5.0'
s.source_files = 'JFCitySelector/Classes/**/*'
end