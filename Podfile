platform :ios, '9.0'
use_frameworks!

target 'test' do
    pod 'R.swift'
    pod 'ObjectMapper', '~> 2.2.2' 
    pod 'AFBuilder', git: 'https://github.com/Khmelevsky/AFBuilder.git'
    pod 'GoogleMaps'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = ’3.0’
        end
    end
end
