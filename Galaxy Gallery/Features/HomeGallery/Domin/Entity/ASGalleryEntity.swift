//
//  ASGalleryEntity.swift
//
//  Created by Vignesh A on 01/03/23
//  Copyright © 2021 . All rights reserved.
//

import SwiftyJSON

struct ASGalleryEntity {

	let url: String
	let copyright: String
	let date: String
	let serviceVersion: String
	let explanation: String
	let title: String
	let hdurl: String
	let mediaType: String

}

struct GalleryEntity: Codable {
    let url: String
    let copyright: String
    let date: String
    let serviceVersion: String
    let explanation: String
    let title: String
    let hdurl: String
    let mediaType: String

    init(from asGalleryEntity: ASGalleryEntity) {
        self.url = asGalleryEntity.url
        self.date = asGalleryEntity.date
        self.explanation = asGalleryEntity.explanation
        self.title = asGalleryEntity.title
        self.hdurl = asGalleryEntity.hdurl
        self.mediaType = asGalleryEntity.mediaType
        self.serviceVersion = asGalleryEntity.serviceVersion
        self.copyright = asGalleryEntity.copyright
    }
}

