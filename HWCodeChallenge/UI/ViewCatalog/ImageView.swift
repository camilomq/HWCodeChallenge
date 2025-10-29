//
//  ImageView.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import SwiftUI

struct ImageView: View {
    let image: ResourceLoad<UIImage>
    let contentMode: ContentMode
    
    var body: some View {
        switch image {
        case .loaded(let image):
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: contentMode)
        case .loading:
            ProgressView()
        case .error(_, let errorText):
            Text(errorText)
        }
    }
    
    init(_ image: ResourceLoad<UIImage>, contentMode: ContentMode = .fit) {
        self.image = image
        self.contentMode = contentMode
    }
}

#Preview("Loaded") {
    ImageView(.loaded(.image(color: .blue)))
}

#Preview("Loading") {
    ImageView(.loading)
}

#Preview("Error") {
    ImageView(.error(ImageLoadError.unknown, "Some error text"))
}

private enum ImageLoadError: Error {
    case unknown
}

extension UIImage {
    static func image(color: UIColor) -> UIImage {
        let rect = CGRect(
            origin: .zero,
            size: CGSize(width: 1, height: 1)
        )
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
