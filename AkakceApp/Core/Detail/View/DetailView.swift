import SwiftUI
import Kingfisher

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    var url: String
    
    init(url: String) {
        self.url = url
        self.viewModel = DetailViewModel(url: url)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(viewModel.detail?.result.mkName ?? "Belirsiz Marka")
                    .foregroundColor(Color(red: 83/255, green: 124/255, blue: 209/255))
                    .font(.caption)
                
                Spacer()
                
                if let rating = viewModel.detail?.result.rating {
                    HStack(spacing: 0) {
                        ForEach(0..<5) { index in
                            if rating >= Double(index + 1) {
                                Image(systemName: "star.fill")
                            } else if rating > Double(index) && rating < Double(index + 1) {
                                Image(systemName: "star.leadinghalf.fill")
                            } else {
                                Image(systemName: "star")
                            }
                        }
                    }
                    .foregroundColor(Color(red: 250/255, green: 217/255, blue: 47/255))
                }

            }
            
            Text(viewModel.detail?.result.productName ?? "Belirsiz")
                .padding(.bottom, 4)
            Text(viewModel.detail?.result.badge ?? "Belirsiz Marka")
                .font(.caption)
                .bold()
                .background(Color(.systemYellow).opacity(0.2))
            
            VStack(spacing: 10){
                HStack{
                    Spacer()
                    KFImage(URL(string: viewModel.detail?.result.imageURL ?? ""))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200,height: 200)
                    Spacer()
                }
                
                Divider()
                
                Text("Kapasite seçenekleri:")
                    .font(.caption2)
                
                if let storageItems = viewModel.detail?.result.storageOptions {
                    HStack {
                        ForEach(storageItems, id: \.self) { storage in
                            StorageButtonView(storage: storage)
                        }
                    }
                    .padding(.bottom)
                }

                
                
                Text("\(viewModel.detail?.result.countOfPrices ?? 0) satıcı içinde kargo dahil en ucuz fiyat seçeneği")
                    .bold()
                    .font(.caption)
                
                PriceView(price: Double(viewModel.detail?.result.price ?? 0), fontSize: 26)
                
                Text((viewModel.detail?.result.freeShipping ?? true ? "Ücretsiz" : "Ücretli") + "Kargo")
                    .foregroundColor(Color(.systemGreen))
                    .font(.system(size: 12))
                    .font(.headline)
                
                Text("Son güncelleme: \(viewModel.detail?.result.lastUpdate ?? "Bilinmiyor")")
                    .font(.caption2)
                    .foregroundColor(Color(.darkGray))
                    
                Spacer()
            }
            
        
        }
        .padding()
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://mocki.io/v1/1a1fb542-22d1-4919-914a-750114879775?code=%7Bcode%7D")
    }
}
