//
//  SubContentView.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 17/3/2022.
//

import SwiftUI

/**
 secondary view showing second pane of 3 tier navigation: list of information items for an information  category: blinded, concealed, clumsy, etc
 */
struct SubContentView: View {
    var category: Category?
    

    var body: some View {
        switch category {
        case .actions:
            ActionsView()
                .frame(minWidth:250.0, idealWidth: 300.0)
        case .conditions:
            ConditionsView()
                .frame(minWidth:250.0, idealWidth: 300.0)
        case .skills:
            SkillsView()
                .frame(minWidth:250.0, idealWidth: 300.0)
        default:
            ScrollView {
                Text("Select a category from the left panel to reveal selectable items in this panel.  If the left panel is not visible use the toolbar button, above, to reveal it.")
                    .padding()
            }
            .frame(minWidth:250.0, idealWidth: 300.0)
        }
    }
}

struct SubContentView_Previews: PreviewProvider {
    static var previews: some View {
        SubContentView(category: nil)
    }
}
