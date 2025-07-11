
import SwiftUI

struct ResponseView: View {
    var response: Response
    
    var body: some View {
        Text(response.text)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 8)
                .fill(.white)
            )
    }
}

#Preview {
    ResponseView(response: Response(text: "I love this song"))
}
