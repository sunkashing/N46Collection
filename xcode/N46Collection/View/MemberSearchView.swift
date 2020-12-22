//
//  MemberSearchView.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 12/22/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

struct MemberSearchView: UIViewControllerRepresentable {
    
    
    func makeCoordinator() -> Coordinator {
        return MemberSearchView.Coordinator(parent: self)
    }
    
    
    // Just change your view that requires search bar...
    var view: MemberPageView
    
    // Integreting UIKit Navigation Controller With SwiftUI View...
    func makeUIViewController(context: Context) -> some UIViewController {
        // requires SwiftUI View...
        let childView = UIHostingController(rootView: view)
        
        let controller = UINavigationController(rootViewController: childView)
        
        // Nav bar data...
        
//        controller.navigationBar.topItem?.title = "nogizaka"
//        controller.navigationBar.prefersLargeTitles = true
        
        // Search bar...
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "メンバー"
        
        // setting delegate...
        searchController.searchBar.delegate = context.coordinator
        
        // disabling dim bg..
        searchController.obscuresBackgroundDuringPresentation = false
        controller.navigationBar.topItem?.hidesSearchBarWhenScrolling = true
        controller.navigationBar.topItem?.searchController = searchController
//        controller.navigationBar.topItem?.
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    // search bar delegate...
    
    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: MemberSearchView
        
        init(parent: MemberSearchView) {
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // when text changes...
            print(searchText)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            // When cancel button is clicked...
        }
    }
}
