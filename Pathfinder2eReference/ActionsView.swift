//
//  ActionsView.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 17/3/2022.
//

import SwiftUI

struct ActionsView: View {
    @State private var actions: Actions? = nil
    @State private var selectedAction: String? = nil
    
    @AppStorage("lastSelectedAction") private var lastSelectedAction: String = ""
    
    var body: some View {
        ScrollViewReader { scroller in
            List(selection: $selectedAction) {
                ForEach(actions?.actions ?? Array<Action>(), id: \.name) { action in
                    NavigationLink(destination: ActionsDetailView(action: action), tag: action.name, selection: $selectedAction) {
                        HStack {
                            Label(action.name.isEmpty ? "!! DATA ERROR !!" : action.name.capitalized, systemImage: "doc.text")
                            Spacer()
                            switch action.mode {
                            case .encounter:
                                Image(systemName: "bolt.shield")
                                    .foregroundColor(Color.gray)
                            case .exploration:
                                Image(systemName: "figure.walk")
                                    .foregroundColor(Color.gray)
                            case .downtime:
                                Image(systemName: "hourglass")
                                    .foregroundColor(Color.gray)
                            }
                        }
                    }
                    .id(action.name)
                    .frame(height: 20.0)
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle(selectedAction == nil ? Category.actions.rawValue.capitalized : "\(selectedAction!.capitalized) action")
            .onAppear {
                actions = Actions.load(jsonResource: "Actions")
                selectedAction = lastSelectedAction.isEmpty ? ( actions?.actions.first?.name ?? nil ) : lastSelectedAction
                scroller.scrollTo(selectedAction)
            }
            .onChange(of: selectedAction) { newValue in
                lastSelectedAction = newValue ?? ""
                scroller.scrollTo(newValue)
            }
        }
    }
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsView()
    }
}
