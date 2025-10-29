//
//  DetailViewModeling.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import UIKit

protocol DetailViewModeling: ObservableObject {
    var image: ResourceLoad<UIImage> { get }
}
