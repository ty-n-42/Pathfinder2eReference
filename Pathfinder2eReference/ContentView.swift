//
//  ContentView.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 15/3/2022.
//

import SwiftUI

enum Category: String, CaseIterable {
    case actions
    case conditions
    case skills
}

/**
 root view showing first pane of 3 tier navigation: list of information categories: actions, conditions, skills, etc
 */
struct ContentView: View {
    @State private var selectedCategory: String? = nil
    
    @AppStorage("lastSelectedCategory") private var lastSelectedCategory: String = ""

    var body: some View {
        ScrollViewReader { scroller in
            NavigationView {
                List(Category.allCasesSorted, id:\.self) { category in
                    NavigationLink(destination: SubContentView(category: category), tag: category.rawValue, selection: $selectedCategory) {
                        Label(category.rawValue, systemImage: "doc.on.doc")
                    }
                }
                .listStyle(SidebarListStyle())
                .frame(minHeight: 300.0, idealHeight: 500.0)

                SubContentView(category: nil)
                    .frame(minWidth:250.0, idealWidth: 300.0)

                DetailView(category: nil, item: nil)
                    .frame(minWidth: 350.0, idealWidth: 400.0)
            }
            .navigationTitle("Pathfinder 2e Reference")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar) { Image(systemName: "sidebar.leading") }
                }
            }
            .onAppear {
                selectedCategory = lastSelectedCategory.isEmpty ? ( Category.allCasesSorted.first?.rawValue ?? nil ) : lastSelectedCategory
            }
        }
    }
    
    /**
     opens and closes the leftmost side bar in the navigation view
     */
    private func toggleSidebar() {
        #if os(iOS)
        #else
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
