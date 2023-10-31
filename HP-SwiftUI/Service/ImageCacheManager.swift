//
//  ImageCacheManager.swift
//  HP-SwiftUI
//
//  Created by Moody on 2023-10-30.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()

    private init() {}
}
