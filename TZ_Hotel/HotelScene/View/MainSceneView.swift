//
//  MainSceneView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 27.09.2023.
//

import SwiftUI


struct MainSceneView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State private var index = 0
    
    var body: some View {
        VStack{
            if let viewData = viewModel.viewData
            {
                ScrollView {
                    VStack {
                        VStack
                        {
                            CarouselImage(item: viewData.imageData)
                            
                            hotelShortData(viewData: viewData)
                            
                        }
                        .background(Constants.Colors.white)
                        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                        
                        VStack(alignment: .leading)
                        {
                            hotelData(viewData: viewData)
                        }
                        .background(Constants.Colors.white)
                        .cornerRadius(15)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                        
                        VStack
                        {
                            SelectedButton(buttonText: "К выбору номера") {
                                //some action
                                coordinator.push(.rooms(viewData.name))
                            }
                            
                            
                        }
                        .background(Constants.Colors.white)
                    }
                    .background(Constants.Colors.basicBackground)
                }
            } else
            {
                Spacer()
                HStack
                {
                    Spacer()
                    ProgressView("Search...")
                        .tint(Constants.Colors.black)
                        .foregroundColor(Constants.Colors.black)
                        .onAppear {
                            if viewModel.viewData == nil{
                                viewModel.fetchData()
                            }
                        }
                    Spacer()
                }
                Spacer()
                
            }
        }
        .background(Constants.Colors.white)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack{
                    Text("Отель")
                        .font(Constants.Fonts.headline1)
                        .foregroundColor(Constants.Colors.black)
                }
            }
        }
    }
    
    
    // MARK: - hotelShortData
    @ViewBuilder private func hotelShortData(viewData: HotelPresentModel) -> some View {
        HStack {
            HStack{
                Image(systemName: "star.fill")
                    .foregroundColor(Constants.Colors.ratingColor)
                    .frame(width: 15,height: 15)
                Text(String(viewModel.viewData!.rating))
                    .font(Constants.Fonts.sfpro16Regular)
                    .foregroundColor(Constants.Colors.ratingColor)
                Text(viewData.ratingDescription)
                    .font(Constants.Fonts.sfpro16Regular)
                    .foregroundColor(Constants.Colors.ratingColor)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .frame(height: 29)
            .background(Constants.Colors.ratingBackground)
            .cornerRadius(5)
            Spacer()
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        
        HStack
        {
            Text(viewData.name)
                .font(Constants.Fonts.sfpro22Regular)
                .foregroundColor(Constants.Colors.black)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
        
        
        HStack
        {
            Button(viewData.adress) {
                // any action
            }
            .font(Constants.Fonts.sfpro14Regular)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
        
        HStack(alignment: .bottom)
        {
            Text("от")
                .font(Constants.Fonts.sfpro30Medium)
                .foregroundColor(Constants.Colors.black)
            Text(String(viewModel.moneyPresent(viewData.minPrice)))
                .foregroundColor(Constants.Colors.black)
                .font(Constants.Fonts.sfpro30Medium)
            Text(viewData.priceDescription)
                .font(Constants.Fonts.sfpro14Light)
                .foregroundColor(Constants.Colors.greyTintColor)
            Spacer()
        }
        
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10))
        
    }
    
    //MARK: - HotelData
    @ViewBuilder private func hotelData(viewData: HotelPresentModel) -> some View {
        HStack
        {
            Text("Об отеле")
                .font(Constants.Fonts.sfpro22Regular)
                .foregroundColor(Constants.Colors.black)
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        
            ForEach(viewData.peculiarities, id: \.self) { data in
                VStack(alignment: .leading)
                {
                    Text(data)
                        .font(Constants.Fonts.sfpro16Regular)
                        .foregroundColor(Constants.Colors.greyTintColor)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background(Constants.Colors.backGroundPeculiarities)
                .cornerRadius(5)

            }
            
        HStack
        {
            Text(viewData.hotelDescription)
                .foregroundColor(Constants.Colors.colorDescription)
                .font(Constants.Fonts.sfpro16Light)
                .multilineTextAlignment(.leading)
        }
        .padding(10)
        
        VStack(spacing: 0)
        {
            Button {
                // some action
            } label: {
                HStack(alignment: .center)
                {
                    Image(Constants.imagesName.emojiHappy)
                        .resizable()
                        .frame(width: 24,height: 24)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                    VStack(alignment: .leading)
                    {
                        Text("Удобства")
                            .font(Constants.Fonts.sfpro16Regular)
                            .foregroundColor(Constants.Colors.buttonTitleBlack)
                        Text("Самое необходимое")
                            .font(Constants.Fonts.sfpro14Regular)
                            .foregroundColor(Constants.Colors.greyTintColor)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 12)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                    
                }
                
            }
            .frame(height: 38)
            .padding(10)
            
            
            Divider()
                .foregroundColor(Constants.Colors.derivrdColor)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .background(Constants.Colors.buttonGrayBackground)
            
            Button {
                // some action
            } label: {
                HStack(alignment: .center)
                {
                    Image(systemName: "checkmark.square")
                        .resizable()
                        .frame(width: 24,height: 24)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                    VStack(alignment: .leading)
                    {
                        Text("Что включено")
                            .font(Constants.Fonts.sfpro16Regular)
                            .foregroundColor(Constants.Colors.buttonTitleBlack)
                        Text("Самое необходимое")
                            .font(Constants.Fonts.sfpro14Regular)
                            .foregroundColor(Constants.Colors.greyTintColor)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 12)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                    
                }
                
            }
            .frame(height: 38)
            .padding(10)
            
            
            Divider()
                .foregroundColor(Constants.Colors.derivrdColor)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .background(Constants.Colors.buttonGrayBackground)
            
            Button {
                // some action
            } label: {
                HStack(alignment: .center)
                {
                    Image(systemName: "xmark.square")
                        .resizable()
                        .frame(width: 24,height: 24)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                    VStack(alignment: .leading)
                    {
                        Text("Что не включено")
                            .font(Constants.Fonts.sfpro16Regular)
                            .foregroundColor(Constants.Colors.buttonTitleBlack)
                        Text("Самое необходимое")
                            .font(Constants.Fonts.sfpro14Regular)
                            .foregroundColor(Constants.Colors.greyTintColor)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 12)
                        .foregroundColor(Constants.Colors.buttonTitleBlack)
                    
                }
                
            }
            .frame(height: 38)
            .padding(10)
            
            
            Divider()
                .foregroundColor(Constants.Colors.derivrdColor)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .background(Constants.Colors.buttonGrayBackground)
            
            
        }
        
        .background(Constants.Colors.buttonGrayBackground)
        .cornerRadius(15)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        
        
    }
    
}

//
//
//
//struct MainSceneView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainSceneView(viewModel: MainViewModel(service: AlamofierService<HotelParseModel>()))
//    }
//}



