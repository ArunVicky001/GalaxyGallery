//
//  ASGalleryResponse.swift
//
//  Created by Vignesh A on 01/03/23
//  Copyright © 2021 . All rights reserved.
//

import SwiftyJSON

struct ASGalleryResponse: StructuredParser {

	let url: String
	let copyright: String
	let date: String
	let serviceVersion: String
	let explanation: String
	let title: String
	let hdurl: String
	let mediaType: String

    init(from json: JSON) {
		url = json["url"].stringValue
		copyright = json["copyright"].stringValue
		date = json["date"].stringValue
		serviceVersion = json["service_version"].stringValue
		explanation = json["explanation"].stringValue
		title = json["title"].stringValue
		hdurl = json["hdurl"].stringValue
		mediaType = json["media_type"].stringValue
    }
}

extension ASGalleryResponse: DomainConvertibleType {
    func asDomain() -> ASGalleryEntity {
        return ASGalleryEntity(
            url: url,
			copyright: copyright,
			date: date,
			serviceVersion: serviceVersion,
			explanation: explanation,
			title: title,
			hdurl: hdurl,
			mediaType: mediaType)
    }
}
