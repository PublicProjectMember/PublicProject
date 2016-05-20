Pod::Spec.new do |spec|
  #项目名称，云助理组件
  spec.name         = 'Reference'
  #版本号
  spec.version      = '0.0.1'
  #开源协议
  spec.license      = 'MIT'
  #对开源项目的描述
  spec.summary      = 'Cloud是云助理客户端和云助理律师端的公共组件'
  #开源项目的首页
  spec.homepage     = 'https://github.com/liuchungui'
  #作者信息
  spec.author       = {'chunguiLiu' => 'chunguiLiu@126.com'}
  #项目的源和版本号
  spec.source       = { :git => 'git@101.200.72.112:/srv/AppComponent/iOS/Reference.git', :tag => spec.version, :submodules => true }
  #适用于ios7及以上版本
  spec.platform     = :ios, '7.0'
  #使用的是ARC
  spec.requires_arc = true
  spec.dependency 'PublicProject'

  # 引用的第三方开源组件
  spec.subspec 'BGUnlockController' do |unlock|
    unlock.source_files = 'BGUnlockController/*.{h,m}'
    unlock.public_header_files = 'BGUnlockController/*.h'
    unlock.resource = 'BGUnlockController/*.xib'
  end

  spec.subspec 'BGPopoverController' do |bgpopovercontroller|
    bgpopovercontroller.source_files = 'BGPopoverController/*.{h,m}'
    bgpopovercontroller.public_header_files = 'BGPopoverController/*.h'
  end
  spec.subspec 'RatingEvaluateView' do |ratingevaluateview|
    ratingevaluateview.source_files = 'RatingEvaluateView/*.{h,m}'
    ratingevaluateview.public_header_files = 'RatingEvaluateView/*.h'
    ratingevaluateview.dependency  'PublicProject/Additions'
  end
  spec.subspec 'SegmentView' do |segmentview|
    segmentview.source_files = 'SegmentView/*.{h,m}'
    segmentview.resource = 'SegmentView/*.xib'
    segmentview.public_header_files = 'SegmentView/*.h'
  end

end
