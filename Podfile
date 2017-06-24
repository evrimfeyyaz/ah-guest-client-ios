platform :ios, '9.0'

target 'Guest Client' do
  use_frameworks!

  # Pods for Guest Client
  pod 'Alamofire', '~> 4.4'
  pod 'AlamofireImage', '~> 3.2'
  pod 'AlamofireNetworkActivityIndicator', '~> 2.1'
  pod 'TPKeyboardAvoiding', '~> 1.3'
  pod 'Locksmith', '~> 3.0'
  pod 'UIBarButtonItem-Badge-Coding', '~> 0.0'
  pod 'TagListView', '~> 1.0'

  target 'Guest ClientTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Guest ClientUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do | installer |
      require 'fileutils'
      FileUtils.cp_r('Pods/Target Support Files/Pods-Guest Client/Pods-Guest Client-acknowledgements.plist', 'Guest Client/Resources/Settings.bundle/Pods-acknowledgements.plist', :remove_destination => true)
  end
end
