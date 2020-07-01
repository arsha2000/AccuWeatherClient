//
//  SourceElement.swift
//  AccuWeatherClient
//
//  Created by Arsha Hassas on 7/1/20.
//

import Foundation

// MARK: - SourceElement
public struct SourceElement: Codable {
    public let dataType: DataSetElement
    public let source: SourceEnum
    public let sourceId: Int
    public let partnerSourceUrl: String?

    enum CodingKeys: String, CodingKey {
        case dataType = "DataType"
        case source = "Source"
        case sourceId = "SourceId"
        case partnerSourceUrl = "PartnerSourceUrl"
    }

    public init(dataType: DataSetElement, source: SourceEnum, sourceId: Int, partnerSourceUrl: String?) {
        self.dataType = dataType
        self.source = source
        self.sourceId = sourceId
        self.partnerSourceUrl = partnerSourceUrl
    }
}

public enum SourceEnum: String, Codable {
    case accuWeather = "AccuWeather"
    case australianGovernmentBureauOfMeteorology = "Australian Government Bureau of Meteorology"
    case earthNetworks = "Earth Networks"
    case environmentAndClimateChangeCanada = "Environment and Climate Change Canada"
    case environmentCanada = "Environment Canada"
    case metOfficeNationalSevereWeatherWarnings = "Met Office National Severe Weather Warnings"
    case plumeLabs = "Plume Labs"
    case uSNationalWeatherService = "U.S. National Weather Service"
    case ukEnvironmentAgency = "UK Environment Agency"
    case ukMetOffice = "UK Met Office"
    case unitedStatesGeologicalSurvey = "United States Geological Survey"
}
