# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

def network_pods
    pod 'Alamofire'
end

target 'decoupled-dependencies-architecture' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    target 'decoupled-dependencies-architectureTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
    target 'Network' do
        network_pods
    end

end
