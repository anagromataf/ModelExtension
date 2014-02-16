Pod::Spec.new do |s|
  s.name         = "ModelExtension"
  s.version      = "0.0.1"
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'
  s.source_files  = 'ModelExtension/ModelExtension/*.{h,m}'
  s.framework  = 'CoreData'
  s.requires_arc = true
end
