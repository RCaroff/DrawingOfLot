//
//  TextFieldAlert.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 23/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//
import Foundation
import SwiftUI
import Combine

fileprivate struct AddPersonField: View {
  var title: String
  var placeholder: String
  var keyboardType: UIKeyboardType
  @Binding var value: String
  @Binding var onError: Bool
  
  var body: some View {
    Group {
      Text(self.title)
        .font(.title)
        .bold()
        .foregroundColor(.secondary)
        .padding(.bottom, 8.0)
      TextField(self.placeholder, text: self.$value)
        .font(.headline)
        .keyboardType(keyboardType)
      Rectangle()
        .foregroundColor(onError ? .red : .secondary)
        .frame(height: 0.5, alignment: .center)
        .padding(.bottom, 20.0)
    }
  }
}

struct AddPersonView: View {
  
  @EnvironmentObject var viewModel: AddPersonViewModel
  
  var body: some View {
    NavigationView {
      ScrollView {
        EncapsulatedView(viewModel: viewModel)
      }
      .navigationBarTitle("Ajouter une personne")
      .modifier(AdaptsToSoftwareKeyboard())
    }
    .onAppear(perform: self.viewModel.loadView)
  }
}

struct EncapsulatedView: View {
  
  private var transition: AnyTransition {
    let insertion = AnyTransition.move(edge: .top)
      .combined(with: .opacity)
    let removal = AnyTransition.move(edge: .top)
      .combined(with: .opacity)
    return .asymmetric(insertion: insertion, removal: removal)
  }
  
  @ObservedObject var viewModel: AddPersonViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      Toggle(
        "Avec un conjoint ?",
        isOn: self.$viewModel.hasJoint.animation(
          .spring(
            response: 0.3,
            dampingFraction: 0.6,
            blendDuration: 1
          )
        )
      )
        .padding(.bottom, 20.0)
        .font(.headline)
        .foregroundColor(.secondary)
      Group {
        AddPersonField(
          title: "Nom :",
          placeholder: "Entrez le nom de la personne à ajouter...",
          keyboardType: .default,
          value: self.$viewModel.nameInputText,
          onError: self.$viewModel.nameEmptyError
        )
        AddPersonField(
          title: "Email :",
          placeholder: "Entrez le mail de la personne à ajouter...",
          keyboardType: .emailAddress,
          value: self.$viewModel.emailInputText,
          onError: self.$viewModel.emailEmptyError
        )
      }
      if self.viewModel.hasJoint {
        Group {
          AddPersonField(
            title: "Nom du conjoint :",
            placeholder: "Entrez le nom du conjoint...",
            keyboardType: .default,
            value: self.$viewModel.jointNameInputText,
            onError: self.$viewModel.jointNameEmptyError
          )
          
          AddPersonField(
            title: "Email du conjoint :",
            placeholder: "Entrez le mail du coinjoint...",
            keyboardType: .emailAddress,
            value: self.$viewModel.jointEmailInputText,
            onError: self.$viewModel.jointEmailEmptyError
          )
        }
        .blur(radius: self.viewModel.hasJoint ? 0 : 10)
        .transition(self.transition)
      }
      
      Button(action: self.viewModel.validateButtonTapped) {
        Text("Valider")
          .font(.title)
          .bold()
      }
      Spacer()
    }
    .padding(.top, 30.0)
    .padding([.leading, .trailing], 20.0)
  }
}

#if DEBUG
struct TextFieldAlert_Previews: PreviewProvider {
  static var previews: some View {
    AddPersonView().environmentObject(AddPersonViewModel())
  }
}
#endif
