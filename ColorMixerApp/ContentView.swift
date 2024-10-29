// Name: Khaled Alshaer
// CWID: 885881623
// Email: Khaled.Alshaer@csu.fullerton.edu

import SwiftUI

struct ContentView: View {
    // Setting the initial values as specified
    @State private var red: Double = 0.314
    @State private var green: Double = 0.746
    @State private var blue: Double = 1.000
    
    @State private var isRedOn: Bool = true
    @State private var isGreenOn: Bool = true
    @State private var isBlueOn: Bool = true

    var body: some View {
        VStack(spacing: 20) {
            // The top display of the title and color
            VStack {
                Text("Color Mixer")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                // Rectangle that reflects the color based on RGB values
                Rectangle()
                    .fill(Color(
                        red: isRedOn ? red : 0,
                        green: isGreenOn ? green : 0,
                        blue: isBlueOn ? blue : 0
                    ))
                    .frame(height: 200)
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.horizontal)
                    .padding(.bottom, 10)
            }
            .padding(.top)

            // RGB controls that are nearer the color display
            VStack(spacing: 20) {
                colorControlView(color: .red, value: $red, isOn: $isRedOn)
                colorControlView(color: .green, value: $green, isOn: $isGreenOn)
                colorControlView(color: .blue, value: $blue, isOn: $isBlueOn)
            }

            Spacer()

            // The bottom has an improved RESET button
            Button(action: reset) {
                Text("RESET")
                    .font(.system(size: 20, weight: .bold))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        }
        .padding()
    }
    
    func reset() {
        // Return to the original configured values
        red = 0.314
        green = 0.746
        blue = 1.000
        isRedOn = true
        isGreenOn = true
        isBlueOn = true
    }
    
    private func colorControlView(color: Color, value: Binding<Double>, isOn: Binding<Bool>) -> some View {
        HStack {
            // Toggle
            Toggle("", isOn: isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: color))
            
            // Slider
            Slider(value: value, in: 0...1)
                .disabled(!isOn.wrappedValue)
                .accentColor(color)
            
            // Three decimal places are included in the numeric text field
            TextField("", value: value, formatter: NumberFormatter.decimalFormatter)
                .frame(width: 50)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .textFieldStyle(PlainTextFieldStyle())
                .multilineTextAlignment(.center)
                .disabled(!isOn.wrappedValue)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

extension NumberFormatter {
    static var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 3
        return formatter
    }
}
