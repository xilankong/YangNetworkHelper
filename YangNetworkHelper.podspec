Pod::Spec.new do |s|
  s.name             = 'YangNetworkHelper'
  s.version          = '0.1.0'
  s.summary          = 'A short description of YangNetworkHelper.'
  s.description      = <<-DESC
    网络中间层
                       DESC

  s.homepage         = 'https://github.com/xilankong/YangNetworkHelper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xilankong' => 'xilankong@126.com' }
  s.source           = { :git => 'https://github.com/xilankong/YangNetworkHelper.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.subspec 'OC' do |oc|
    oc.source_files = 'YangNetworkHelper/Classes/OC/**/*'
    oc.dependency 'AFNetworking'
  end

  s.subspec 'SWIFT' do |swift|
    swift.source_files = 'YangNetworkHelper/Classes/SWIFT/**/*'
    swift.dependency 'Alamofire'
  end

end
