//
//  ParseAppsFlyerData.swift
//  
//
//  Created by Senior Developer on 25.07.2022.
//
import Foundation

final class ParseAppsFlyerData {
    
    var urlParameters: ((String?) -> Void)?
    var installCompletion: ((Install?) -> Void)?
    
    func parseCampaign(_ conversionInfo: [AnyHashable : Any]) {
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
    
    init(){}
}

public enum Install: String {
    case organic = "Non-organic"
    case nonOrganic = "Organic"
}
