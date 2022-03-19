//
//  ConditionsDetailView.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 19/3/2022.
//

import SwiftUI

struct ConditionsDetailView: View {
    let condition: Condition
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                Text(.init(condition.description))
                    .padding(.top, 30.0)
                    .padding([.leading, .trailing, .bottom], 20.0)
            }
        }
        .frame(minWidth: 200.0, minHeight: 400.0) // note: needs to manually keep these values the same as what is specified for DetailView in ContentView
    }
}

struct ConditionsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionsDetailView(condition: Condition(name: "Test condition", description: "Test condition description", affects: [Affect.player]))
    }
}
