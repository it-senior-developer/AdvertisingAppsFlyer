//
//  ParseAppsFlyerData.swift
//  
//
//  Created by Senior Developer on 25.07.2022.
//
import Foundation

final public class ParseAppsFlyerData {
    
    public var urlParameters: ((String?) -> Void)?
    public var installCompletion: ((Install?) -> Void)?
    
    public func parseCampaign(_ conversionInfo: [AnyHashable : Any]) {
        if let afStatus = conversionInfo["af_status"] as? String {
            let install = Install(rawValue: afStatus)
            installCompletion?(install)
        }
        guard let campaign = conversionInfo["campaign"] as? String  else { return }
        guard campaign != "" else { self.urlParameters?(nil); return }
        let arrayString = campaign.split(separator: "_")
        let arrayValues = arrayString.map { String($0) }
        self.createParameters(values: arrayValues)
    }
    
    private func createParameters(values: [String]){
        var parameters = ""
        self.urlParameters?(parameters)
    }
    
    public init(){}
}

public enum Install: String {
    case organic = "Non-organic"
    case nonOrganic = "Organic"
}
