import AppsFlyerLib
import AppTrackingTransparency

public final class GDAppsFlyer {
    
    private let appsFlyerDelegate = AppsFlyerDelegate()
    private let appsFlyerDeepLinkDelegate = AppsFlyerDeepLinkDelegate()
    private let parseAppsFlyerData = ParseAppsFlyerData()
    
    public var urlParameters: ((String?) -> Void)?
    public var installCompletion: ((Install?) -> Void)?
    public var completionDeepLinkResult: ((DeepLinkResult) -> Void)?
    
    public func setup(appID: String, devKey: String, interval: Double = 120){
        self.setup()
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: interval)
        AppsFlyerLib.shared().appsFlyerDevKey     = devKey
        AppsFlyerLib.shared().appleAppID          = appID
        AppsFlyerLib.shared().delegate            = self.appsFlyerDelegate
        AppsFlyerLib.shared().deepLinkDelegate    = self.appsFlyerDeepLinkDelegate
        AppsFlyerLib.shared().isDebug             = true
        AppsFlyerLib.shared().useUninstallSandbox = true
        AppsFlyerLib.shared().minTimeBetweenSessions = 10
        AppsFlyerLib.shared().start(completionHandler: { (dictionary, error) in
            if (error != nil){
                print(error ?? "")
                return
            } else {
                print(dictionary ?? "")
                return
            }
        })
    }
    
    public func setDebag(isDebug: Bool){
        AppsFlyerLib.shared().isDebug = isDebug
    }
    
    public func start(){
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        AppsFlyerLib.shared().start()
        requestTrackingAuthorization()
    }
    
    public func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status {
                    case .denied:
                        print("AuthorizationSatus is denied")
                    case .notDetermined:
                        print("AuthorizationSatus is notDetermined")
                    case .restricted:
                        print("AuthorizationSatus is restricted")
                    case .authorized:
                        print("AuthorizationSatus is authorized")
                    @unknown default:
                        fatalError("Invalid authorization status")
                }
            }
        }
    }
    
    private func setup(){
        appsFlyerDeepLinkDelegate.completionDeepLinkResult = completionDeepLinkResult
        appsFlyerDelegate.installCompletion = installCompletion
        appsFlyerDelegate.urlParameters = urlParameters
    }

    public init(){}
}
//https://app.appsflyer.com/id1662068962?pid=conversionTest1&idfa=3E7D5A70-C304-4494-A12F-352A30E4BBB5

