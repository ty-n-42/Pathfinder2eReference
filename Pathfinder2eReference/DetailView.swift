//
//  DetailView.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 17/3/2022.
//

import SwiftUI

struct DetailView: View {
    let category: Category?
    let item: String?
    
    var body: some View {
        switch category {
        case .actions:
            Text("Details of an Action item")
        case .conditions:
            Text("Detail of a Condition item")
        case .skills:
            Text("Details of a skill item")
        default:
            ScrollView {
                Text("Select an item from the middle panel to reveal item details in this panel.")
                    .padding(.top, 30.0)
                    .padding([.leading, .trailing, .bottom], 20.0)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(category: nil, item: nil)
    }
}
