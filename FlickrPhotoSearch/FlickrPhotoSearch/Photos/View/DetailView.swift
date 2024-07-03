//
//  DetailView.swift
//  FlickrPhotoSearch
//
//  Created by Sruthi on 7/3/24.
//

import SwiftUI

struct DetailView: View {
    let item: Item
    @State private var plainDescription: String = ""
    @State private var buttonHeight: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: item.media.m)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                Text(item.title)
                    .font(.headline)
                if !plainDescription.isEmpty {
                    Text(plainDescription)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                } else {
                    ProgressView()
                        .padding()
                        .onAppear {
                            plainDescription = convertHtmlToPlainText(htmlString: item.description) ?? ""
                        }
                }
                Text("By: \(item.author)")
                    .font(.subheadline)
                if let date = DateFormatter.flickr.date(from: item.published) {
                    Text("Published: \(date, formatter: DateFormatter.flickrDisplay)")
                        .font(.subheadline)
                } else {
                    Text("Published: \(item.published)")
                        .font(.subheadline)
                }
                Button(action: shareImage) {
                    Text("Share")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .frame(height: buttonHeight)
                        .cornerRadius(buttonHeight/2)
                }
                .padding(16)
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .navigationTitle("Photo Details")
        .onAppear {
            buttonHeight = 40
        }
    }
    
    // MARK: Helper
    func convertHtmlToPlainText(htmlString: String) -> String? {
        do {
            guard let data = htmlString.data(using: .utf8) else {
                return nil
            }
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            // Convert HTML data to attributed string
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            
            // Extract plain text from attributed string
            var plainText = attributedString.string
            
            plainText = plainText.replacingOccurrences(of: "&amp;", with: "&")
            plainText = plainText.replacingOccurrences(of: "&nbsp;", with: " ")
            return plainText
        } catch {
            return nil
        }
    }
    
    func shareImage() {
        let items: [Any] = [item.title, item.author, item.media.m]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        // Present the UIActivityViewController
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}
