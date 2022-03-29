//
//  SkillsDetailView.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 28/3/2022.
//

import SwiftUI

struct ModeView: View {
    let mode: Mode
    
    var body: some View {
        HStack {
            Text("mode:")
                .modifier(NormalText())
                .lineLimit(1)
                .frame(minHeight: 20.0)
            ForEach(Mode.allCasesSorted, id: \.rawValue) { _mode in
                Text(_mode.rawValue)
                    .modifier(ColoredListText(color: mode == _mode ? mediumseagreen : darkslategray ))
                    .lineLimit(1)
            }
        }
    }
}

struct SkillSet: View {
    let skill: SkillGroup
    
    var body: some View {
        HStack {
            Text("skillset:")
                .modifier(NormalText())
                .lineLimit(1)
                .frame(minHeight: 20.0)
            ForEach(SkillGroup.allCasesSorted, id: \.rawValue) { _skill in
                Text(_skill.rawValue)
                    .modifier(ColoredListText(color: skill == _skill ? mediumseagreen : darkslategray ))
                    .lineLimit(1)
            }
        }
    }
}

struct AbilityView: View {
    let ability: Ability
    
    var body: some View {
        HStack {
            Text("ability:")
                .modifier(NormalText())
                .lineLimit(1)
                .frame(minHeight: 20.0)
            ForEach(Ability.allCasesSorted, id: \.rawValue) { _ability in
                Text(_ability.rawValue)
                    .modifier(ColoredListText(color: ability == _ability ? mediumseagreen : darkslategray ))
                    .lineLimit(1)
            }
        }
    }
}

struct CompetenceView: View {
    let competence: Competence
    
    var body: some View {
        HStack {
            Text("competence:")
                .modifier(NormalText())
                .lineLimit(1)
                .frame(minHeight: 20.0)
            ForEach(Competence.allCasesSorted, id: \.rawValue) { _competence in
                Text(_competence.rawValue)
                    .modifier(ColoredListText(color: competence == _competence ? .yellow : darkslategray ))
                    .lineLimit(1)
            }
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
//                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            ModeView(mode: skill.mode)
                .frame(maxWidth: .infinity, alignment: .leading)
            SkillSet(skill: skill.skillGroup)
                .frame(maxWidth: .infinity, alignment: .leading)
            AbilityView(ability: skill.keyAbility)
                .frame(maxWidth: .infinity, alignment: .leading)
            CompetenceView(competence: skill.competence)
                .frame(maxWidth: .infinity, alignment: .leading)

            Traits(traits: skill.traits)
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
