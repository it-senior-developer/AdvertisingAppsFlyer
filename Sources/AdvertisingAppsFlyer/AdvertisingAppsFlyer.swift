import AppsFlyerLib

public final class GDAppsFlyer {
    
    private let appsFlyerDelegate = AppsFlyerDelegate()
    private let appsFlyerDeepLinkDelegate = AppsFlyerDeepLinkDelegate()
    
    public func setup(appID: String, devKey: String, interval: Double = 120){
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

    public init(){}
}
