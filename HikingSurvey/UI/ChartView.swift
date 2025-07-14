//
//  ChartView.swift
//  HikingSurvey
//
//  Created by Станислав Леонов on 14.07.2025.
//

import SwiftUI
import Charts

struct ChartView: View {
    var response: [Response]
    
    init(response: [Response]) {
        self.response = response.sorted { $0.score < $1.score }
    }
    
    var body: some View {
        Chart(response) { response in
            SectorMark(angle: .value("Type", 1))
                .foregroundStyle(by: .value("sentiment",response.sentiment))
        }
        .chartForegroundStyleScale([
            Sentiments.positive: Sentiments.positive.sentimentColor,
            Sentiments.negative: Sentiments.negative.sentimentColor,
            Sentiments.moderate: Sentiments.moderate.sentimentColor
        ])
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
