//
//  SkillsDetailView.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 28/3/2022.
//

import SwiftUI

struct SkillAndCompetence: View {
    let skill: SkillGroup
    let competence: Competence
    
    var body: some View {
        VStack {
            HStack {
                Text("skill:")
                    .modifier(NormalText())
                    .frame(minHeight: 20.0)
                Text(skill.rawValue)
                    .modifier(ColoredListText(color: mediumseagreen))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Text("competence:")
                    .modifier(NormalText())
                    .frame(minHeight: 20.0)
                Text(competence.rawValue)
                    .modifier(ColoredListText(color: mediumseagreen))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SkillsDetailView: View {
    @State var skill: Skill
    
    var body: some View {
        VStack {
            Name(name: skill.name.isEmpty ? "!! DATA ERROR !!" : skill.name.capitalized, imageName: "graduationcap")
                .frame(maxWidth: .infinity, alignment: .leading)
            Affects(affects: skill.affects)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            DurationAndType(duration: skill.duration, type: skill.type)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            SkillAndCompetence(skill: skill.skillGroup, competence: skill.competence)
                .frame(maxWidth: .infinity, alignment: .leading)

            Traits(traits: skill.traits)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // skill group
            // key ability
            // competence
            // mode
            
            ScrollView([.vertical], showsIndicators: true) {
                TitleAndText(title: "Requirement", text: skill.requirement)

                TitleAndText(title: "Description", text: skill.description)

                TitleAndText(title: "Critical Success", text: skill.criticalSuccess)

                TitleAndText(title: "Success", text: skill.success)

                TitleAndText(title: "Failure", text: skill.failure)

                TitleAndText(title: "Critical Failure", text: skill.criticalFailure)
            }
        }
        .padding()
        .frame(minWidth: 350.0, idealWidth: 400.0)
    }
}

struct SkillsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsDetailView(skill: Skill(name: "Name", skillGroup: .acrobatics, keyAbility: .charisma, competence: .trained, type: .action, duration: 1, mode: .downtime, traits: [.attack], requirement: "Requirement", description: "Description", criticalSuccess: "Critical success", success: "Success", failure: "Failure", criticalFailure: "Critical failure", affects: [.player]))
    }
}
