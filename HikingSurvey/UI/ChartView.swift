import SwiftUI
import Charts

struct ChartView: View {
    var response: [Response]
    @State private var flipped = false
    @State private var fadedOut = false
    init(response: [Response]) {
        self.response = response.sorted { $0.score < $1.score }
    }
    
    var body: some View {
        Chart(response) { response in
            SectorMark(angle: .value("Type", 1),innerRadius: .ratio(0.75))
                .foregroundStyle(by: .value("sentiment",response.sentiment))
        }
        .chartForegroundStyleScale([
            Sentiments.positive: Sentiments.positive.sentimentColor,
            Sentiments.negative: Sentiments.negative.sentimentColor,
            Sentiments.moderate: Sentiments.moderate.sentimentColor
        ])
        .chartBackground { chartProxy in
            GeometryReader { geomerty in
                if let anchor = chartProxy.plotFrame {
                    let frame = geomerty[anchor]
                    Image(systemName: "figure.hiking")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: frame.height * 0.4)
                        .foregroundStyle(Color(white:0.59))
                        .position(x: frame.midX, y: frame.midY)
                        .scaleEffect(x: flipped ? -1 : 1, y: 1)
                        .opacity(fadedOut ? 0 : 1)
                        .position(x: frame.midX, y: frame.midY)
                        .animation(.easeInOut(duration: 1), value: flipped)
                        .animation(.easeInOut(duration: 1), value: fadedOut)
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                                fadedOut = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    flipped.toggle()
                                    fadedOut = false
                                }
                            }
                        }
                }
            }
        }
        .chartLegend(.hidden)
        .frame(height: 200)
        .padding()
        HStack(spacing: 16) {
            LegendItem(color: Sentiments.positive.sentimentColor, text: Sentiments.positive.rawValue)
            LegendItem(color: Sentiments.moderate.sentimentColor, text: Sentiments.moderate.rawValue)
            LegendItem(color: Sentiments.negative.sentimentColor, text: Sentiments.negative.rawValue)
        }
    }
}

struct LegendItem: View {
    var color: Color
    var text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            Text(text)
                .font(.headline)
        }
    }
}

#Preview {
    ContentView()
}
