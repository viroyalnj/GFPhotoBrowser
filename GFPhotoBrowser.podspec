#
# Be sure to run `pod lib lint GFPhotoBrowser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GFPhotoBrowser'
  s.version          = '0.3.1'
  s.summary          = 'iOS Photos 框架的简单封装'
  s.module_name      = 'GFPhotoBrowser'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                    一个查询数据的Data source
                    若干相关界面
                       DESC

  s.homepage         = 'https://github.com/guofengld/GFPhotoBrowser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guofengld' => 'guofengld@gmail.com' }
  s.source           = { :git => 'https://github.com/guofengld/GFPhotoBrowser.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/guofengjd'

  s.ios.deployment_target = '8.1'
  s.requires_arc = true

  s.source_files = 'GFPhotoBrowser/Classes/GFPhotoBrowser.h'
  
   s.resource_bundles = {
     'Resources' => ['GFPhotoBrowser/Assets/*.png', 'GFPhotoBrowser/Assets/*.lproj']
   }

  s.public_header_files = 'GFPhotoBrowser/Classes/GFPhotoBrowser.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MBProgressHUD'
  s.dependency 'Masonry'
  s.dependency 'GFCocoaTools'

  s.subspec 'Models' do |ss|
    ss.source_files = ['GFPhotoBrowser/Classes/GFPhotosDataSource.{h,m}', 'GFPhotoBrowser/Classes/NSBundle+GFPhotoBrowser.{h,m}']
  end

  s.subspec 'Cells' do |ss|
    ss.dependency 'GFPhotoBrowser/Models'
    ss.source_files = 'GFPhotoBrowser/Classes/GFPhotoCell.{h,m}', 'GFPhotoBrowser/Classes/GFAlbumCell.{h,m}'
  end

  s.subspec 'Controllers' do |ss|
    ss.dependency 'GFPhotoBrowser/Cells'
    ss.source_files = 'GFPhotoBrowser/Classes/GFAlbumViewController.{h,m}', 'GFPhotoBrowser/Classes/GFPhotoBrowserNavigationController.{h,m}', 'GFPhotoBrowser/Classes/GFPhotoBrowserViewController.{h,m}', 'GFPhotoBrowser/Classes/GFPhotoCropViewController.{h,m}'
  end

end
