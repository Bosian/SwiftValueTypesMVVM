platform :ios, '8.0'
use_frameworks!

def shared
    pod 'EVReflection', "2.18.1"
end

target 'POPMVVM' do
    shared
end

target 'POPMVVMTests' do
    shared
end

target 'POPMVVMUITests' do
    shared
end

post_install do |installer|

installer.pods_project.targets.each do |target|

target.build_configurations.each do |config|

config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'

end

end

end



