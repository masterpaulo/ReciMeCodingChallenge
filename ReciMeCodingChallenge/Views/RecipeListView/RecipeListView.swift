//
//  RecipeListView.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import SwiftUI

struct RecipeListView: View {
    
    @StateObject private var viewModel: RecipeListViewModel = RecipeListViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
       
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid  (columns: columns, spacing: 10) {
                ForEach(viewModel.recipeList, id: \.id) { recipe in
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
                            Spacer()
                        }
                        .padding(.horizontal, 4)
                        
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: .infinity)
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
