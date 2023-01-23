//
//  AppsFlyerDelegate.swift
//  
//
//  Created by Senior Developer on 25.07.2022.
//
import AppsFlyerLib
import Foundation

final class AppsFlyerDelegate: NSObject, AppsFlyerLibDelegate {
    
    private let parseAppsFlyerData = ParseAppsFlyerData()
    
    public var urlParameters: ((String?) -> Void)?
    
    public func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        self.parseAppsFlyerData.urlParameters = self.urlParameters
        self.parseAppsFlyerData.parseCampaign(conversionInfo)
    }
    
    public func onConversionDataFail(_ error: Error) {
        self.parseAppsFlyerData.urlParameters?(nil)
        print("Error server data: class: AppsFlyerGetData ->, function: onConversionDataFail -> data: onConversionDataSuccess ->, description: ", error.localizedDescription)
    }
    
    public func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        print("\(attributionData)")
    }
    
    public func onAppOpenAttributionFailure(_ error: Error) {
        print(error)
    }
    
    override init(){}
}
