//
//  ContentView.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ListViewModel<ItemViewModel, FlickrRemoteService>(
        title: "Flickr Photos",
        remoteService: .init()
    )
    
    var body: some View {
        NavigationStack {
            ListView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}
