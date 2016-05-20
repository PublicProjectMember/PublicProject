Pod::Spec.new do |spec|
  spec.name         = 'PublicProject'
  spec.version      = '0.0.1'
  spec.license      = 'MIT'
  spec.summary      = 'PublicProject 是一个基础框架'
  spec.homepage     = 'https://github.com/PublicProjectMember/PublicProject'
  spec.author       = {"liuchungui"=>"chunguiLiu@126.com"}
  spec.source       = { :git => 'https://github.com/PublicProjectMember/PublicProject.git', :tag => spec.version }
  spec.platform     = :ios, '7.0'
  spec.requires_arc = true
  spec.frameworks = 'Foundation'

  #helper方法
  spec.subspec 'Helper' do |helper|
    helper.source_files = 'Helper/**/*.{h,m}'
    helper.public_header_files = 'Helper/Helper.h'
  end

  #UIView等扩展方法
  spec.subspec 'Additions' do |additions|
    additions.source_files = 'Additions/**/*.{h,m}'
    additions.public_header_files = 'Additions/*.h'
  end

  #Jastor
  spec.subspec 'Jastor' do |jastor|
    jastor.source_files = 'Jastor/**/*.{h,m}'
    jastor.public_header_files = 'Jastor/jastor.h'
  end

  #宏
  spec.subspec 'Macro' do |macro|
    macro.source_files = 'Macro/**/*.{h,m}'
    macro.public_header_files = 'Macro/*.h'
  end

  #工具方法
  spec.subspec 'Utils' do |utils|
    utils.source_files = 'Utils/**/*.{h,m}'
    utils.public_header_files = 'Utils/*.h'
    utils.dependency 'PublicProject/Macro'
    utils.frameworks = 'Foundation'
  end

  spec.subspec 'Vendors' do |vendors|
    vendors.subspec 'Timer' do |timer|
      timer.source_files = 'Vendors/Timer/**/*.{h,m}'
      timer.public_header_files = 'Vendors/Timer/*.h'
      timer.dependency 'PublicProject/Macro'
    end

    vendors.subspec 'GTMBase64' do |base64|
      base64.source_files = 'Vendors/GTMBase64/**/*.{h,m}'
      base64.public_header_files = 'Vendors/GTMBase64/*.h'
      base64.requires_arc = false
    end

    vendors.subspec 'Json' do |json|
      json.source_files = 'Vendors/Json/**/*.{h,m}'
      json.public_header_files = 'Vendors/Json/*.h'
      json.requires_arc = false
    end

    vendors.subspec 'QBase64' do |qBase64|
      qBase64.source_files = 'Vendors/QBase64/**/*.{h,m}'
      qBase64.public_header_files = 'Vendors/QBase64/*.h'
      qBase64.requires_arc = false
    end

    vendors.subspec 'OpenUDID' do |openUDID|
      openUDID.source_files = 'Vendors/OpenUDID/**/*.{h,m}'
      openUDID.public_header_files = 'Vendors/OpenUDID/*.h'
      openUDID.requires_arc = false
    end
  end

  # 引用的第三方开源组件
  spec.subspec 'Reference' do |refrencen|
    refrencen.subspec 'BGUnlockController' do |unlock|
      unlock.source_files = 'Reference/BGUnlockController/*.{h,m}'
      unlock.public_header_files = 'Reference/BGUnlockController/*.h'
      unlock.resource = 'BGUnlockController/*.xib'
    end

    refrencen.subspec 'BGPopoverController' do |bgpopovercontroller|
      bgpopovercontroller.source_files = 'Reference/BGPopoverController/*.{h,m}'
      bgpopovercontroller.public_header_files = 'Reference/BGPopoverController/*.h'
    end
    refrencen.subspec 'RatingEvaluateView' do |ratingevaluateview|
      ratingevaluateview.source_files = 'Reference/RatingEvaluateView/*.{h,m}'
      ratingevaluateview.public_header_files = 'Reference/RatingEvaluateView/*.h'
      ratingevaluateview.dependency  'PublicProject/Additions'
    end
    refrencen.subspec 'SegmentView' do |segmentview|
      segmentview.source_files = 'Reference/SegmentView/*.{h,m}'
      segmentview.resource = 'Reference/SegmentView/*.xib'
      segmentview.public_header_files = 'SegmentView/*.h'
    end
  end

end
