# source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.0'
use_frameworks!

def testing_pods
  pod 'Mocker'
  pod 'RealmSwift'
end

target 'GH_App' do
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxRealm'
    testing_pods
end

target 'GH_AppTests' do
  pod 'OHHTTPStubs/Swift'
  testing_pods
end

target 'GH_AppUITests' do
  testing_pods
end
