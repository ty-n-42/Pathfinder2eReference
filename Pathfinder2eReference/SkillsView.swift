//
//  SkillsView.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 17/3/2022.
//

import SwiftUI

struct SkillsView: View {
    @State private var skills: Skills? = nil
    @State private var selectedSkill: String? = nil
    
    @AppStorage("lastSelectedSkill") private var lastSelectedSkill: String = ""

    var body: some View {
        ScrollViewReader { scroller in
            List(selection: $selectedSkill) {
                ForEach(skills?.skills ?? Array<Skill>(), id:\.name) { skill in
                    NavigationLink(destination: SkillsDetailView(skill: skill), tag: skill.name, selection: $selectedSkill) {
                        HStack {
                            Label(skill.name.isEmpty ? "!! DATA ERROR !!" : skill.name.capitalized, systemImage: "doc.text")
                            Spacer()
                            Image(systemName: "graduationcap")
                                .foregroundColor(Color.gray)
                        }
                    }
                    .id(skill.name)
                    .frame(height: 20.0)
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle(selectedSkill == nil ? Category.skills.rawValue.capitalized : "\(selectedSkill!.capitalized) skill")
            .onAppear {
                skills = Skills.load(jsonResource: "Skills")
                selectedSkill = lastSelectedSkill.isEmpty ? ( skills?.skills.first?.name ?? nil ) : lastSelectedSkill
                scroller.scrollTo(selectedSkill)
            }
            .onChange(of: selectedSkill) { newValue in
                lastSelectedSkill = newValue ?? ""
                scroller.scrollTo(newValue)
            }
        }
    }
}

struct SkillsView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsView()
    }
}
