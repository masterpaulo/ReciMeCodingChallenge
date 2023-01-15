//
//  RecipeListView.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import SwiftUI

struct RecipeListView: View {
    
    @StateObject private var viewModel: RecipeListViewModel = RecipeListViewModel()
    
    @State private var showDetails: Bool = false
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            if viewModel.loadingState == .loaded {
                ScrollView {
                    LazyVGrid  (columns: columns, spacing: 10) {
                        ForEach(viewModel.recipeList, id: \.id) { recipe in
                            Button {
                                print("Tapped \(recipe.title)")
                                viewModel.selectedRecipe = recipe
                                showDetails = true
                            } label: {
                                VStack{
                                    ZStack(alignment: .bottom) {
                                        Image("")
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 200)
                                            .background(Color.gray)
                                            .cornerRadius(10)
                                        
                                        HStack {
                                            Text("\(recipe.totalPrepAndCookTime)m")
                                            Spacer()
                                            Text("\(recipe.numSaves ?? 0)")
                                        }
                                        .padding(10)
                                    }
                                    
                                    HStack {
                                        Text(recipe.title)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    .frame(height: 50)
                                    .padding(.horizontal, 4)
                                    
                                }
                            }
                            .foregroundColor(.primary)
                        }
                    }
                    .padding(.horizontal)
                }
                .sheet(isPresented: $showDetails, content: {
                    if let recipe = viewModel.selectedRecipe {
                        RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe))
                    }
                })
                .frame(maxHeight: .infinity)
            } else if viewModel.loadingState == .loading {
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .onAppear(perform: {
            self.viewModel.loadRecipeList()
        })
        
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
