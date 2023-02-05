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
        let parameters = self.createParameters(conversionInfo: conversionInfo)
        print(parameters)
    }
    
    private func createParameters(conversionInfo: [AnyHashable : Any]) -> String {
        let resultArray = conversionInfo.compactMap({ key, value in
            if let key = key as? String, let value = value as? String, let keyCreate = Key(rawValue: key) {
                let keyParameter = getAnalog(key: keyCreate)
                let valueParameter = value
                return keyParameter + "+" + valueParameter
            } else {
                return nil
            }
        })
        let parameters = resultArray.joined(separator: "&")
        return parameters
    }
    
    private func getAnalog(key: Key) -> String {
        switch key {
            case .pid:
                return Analog.utmSource.rawValue
            case .af_channel:
                return Analog.utmMedium.rawValue
            case .c:
                return Analog.utmCampaign.rawValue
            case .af_adset:
                return Analog.utmContent.rawValue
            case .af_ad:
                return Analog.utmTerm.rawValue
        }
    }
    
    init(){}
}

public enum Install: String {
    case organic = "Organic"
    case nonOrganic = "Non-organic"
}

public enum Key: String {
    case pid
    case af_channel
    case c
    case af_adset
    case af_ad
}

public enum Analog: String {
    case utmSource = "utm_source"
    case utmMedium = "utm_medium"
    case utmCampaign = "utm_campaign"
    case utmContent = "utm_content"
    case utmTerm = "utm_term"
}
