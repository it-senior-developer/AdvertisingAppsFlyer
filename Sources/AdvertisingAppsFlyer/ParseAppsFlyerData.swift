//
//  ParseAppsFlyerData.swift
//  
//
//  Created by Senior Developer on 25.07.2022.
//
import Foundation

final public class ParseAppsFlyerData {
    
    public var urlParameters: ((String?) -> Void)?
    
    public func parseCampaign(_ conversionInfo: [AnyHashable : Any]) {
        guard let campaign = conversionInfo["campaign"] as? String  else { return }
        guard campaign != "" else { self.urlParameters?(nil); return }
        let arrayString = campaign.split(separator: "_")
        let arrayValues = arrayString.map { String($0) }
        self.createParameters(values: arrayValues)
    }
    
    private func createParameters(values: [String]){
        var parameters = ""
        values.enumerated().forEach { index, value in
            parameters += "&sub\(index + 1)=\(value)"
        }
        self.urlParameters?(parameters)
    }
}
