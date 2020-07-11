//
//  SourceElement.swift
//  AccuWeatherClient
//
//  Created by Arsha Hassas on 7/1/20.
//

import Foundation

// MARK: - SourceElement
public struct SourceElement: Codable {
    public let dataType: String
    public let source: String
    public let sourceId: Int
    public let partnerSourceUrl: String?

    enum CodingKeys: String, CodingKey {
        case dataType = "DataType"
        case source = "Source"
        case sourceId = "SourceId"
        case partnerSourceUrl = "PartnerSourceUrl"
    }

    public init(dataType: String, source: String, sourceId: Int, partnerSourceUrl: String?) {
        self.dataType = dataType
        self.source = source
        self.sourceId = sourceId
        self.partnerSourceUrl = partnerSourceUrl
    }
}
