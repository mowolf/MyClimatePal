//
//  ViewExtension.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 07.10.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//
import SwiftUI

// CALL WITH .navigate(to: UploadView().environmentObject(model), when: $moveToUpload)

extension View {

    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    }
}
