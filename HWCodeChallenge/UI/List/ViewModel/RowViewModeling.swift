//
//  RowViewModeling.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import Foundation
import UIKit

protocol RowViewModeling: ObservableObject {
    var title: String { get }
    var image: ResourceLoad<UIImage> { get }
    func start() async
}
