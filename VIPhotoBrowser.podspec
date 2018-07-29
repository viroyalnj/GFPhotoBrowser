#
# Be sure to run `pod lib lint VIPhotoBrowser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VIPhotoBrowser'
  s.version          = '0.4.1'
  s.summary          = 'iOS Photos 框架的简单封装'
  s.module_name      = 'VIPhotoBrowser'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                    一个查询数据的Data source
                    若干相关界面
                       DESC

  s.homepage         = 'https://github.com/viroyalnj/VIPhotoBrowser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guofengld' => 'guofengld@gmail.com' }
  s.source           = { :git => 'https://github.com/viroyalnj/VIPhotoBrowser.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/guofengjd'

  s.ios.deployment_target = '8.1'
  s.requires_arc = true

  s.source_files = 'VIPhotoBrowser/Classes/GFPhotoBrowser.h'
  
   s.resource_bundles = {
     'Resources' => ['VIPhotoBrowser/Assets/*.png', 'VIPhotoBrowser/Assets/*.lproj']
   }

  s.public_header_files = 'VIPhotoBrowser/Classes/GFPhotoBrowser.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MBProgressHUD'
  s.dependency 'Masonry'
  s.dependency 'VICocoaTools'

  s.subspec 'Models' do |ss|
    ss.source_files = ['VIPhotoBrowser/Classes/GFPhotosDataSource.{h,m}', 'VIPhotoBrowser/Classes/NSBundle+GFPhotoBrowser.{h,m}']
  end

  s.subspec 'Cells' do |ss|
    ss.dependency 'VIPhotoBrowser/Models'
    ss.source_files = 'VIPhotoBrowser/Classes/GFPhotoCell.{h,m}', 'VIPhotoBrowser/Classes/GFAlbumCell.{h,m}'
  end

  s.subspec 'Controllers' do |ss|
    ss.dependency 'VIPhotoBrowser/Cells'
    ss.source_files = 'VIPhotoBrowser/Classes/GFAlbumViewController.{h,m}', 'VIPhotoBrowser/Classes/GFPhotoBrowserNavigationController.{h,m}', 'VIPhotoBrowser/Classes/GFPhotoBrowserViewController.{h,m}', 'VIPhotoBrowser/Classes/GFPhotoCropViewController.{h,m}'
  end

end
