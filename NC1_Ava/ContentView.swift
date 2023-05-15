import SwiftUI


struct ContentView: View {
    
    // Initialize Variable
    @State private var selectedTab = 0
    @State private var a = ""
    @State private var b = ""
    @State private var c = ""
    @State private var root1_Equation = ""
    @State private var root2_Equation = ""
    @State private var equation = ""
    @State private var root1_Root: Double? = nil
    @State private var root2_Root: Double? = nil
    @State private var discriminant_Root: Double? = nil
    @State private var diskriminan: Double? = 0.0
    @State private var result: String = ""
    
    // Segmented Picker
    let tabs = ["Root", "Equation"]
    
    // Calculate Roots Functions
    func calculateRoots() {
        guard let a = Double(self.a),
              let b = Double(self.b),
              let c = Double(self.c)
        else {
            return
        }
        
        let (root1_Root, root2_Root, discriminant_Root) = quadraticFormula(a: a, b: b, c: c)
        self.root1_Root = root1_Root
        self.root2_Root = root2_Root
        self.discriminant_Root = discriminant_Root
    }
    
    // Quadratic Formula Functions
    func quadraticFormula(a: Double, b: Double, c: Double) -> (Double?, Double?, Double?) {
        let discriminant_Root = b * b - 4 * a * c
        if discriminant_Root < 0 {
            return (nil, nil,discriminant_Root)
        } else {
            let root1_Root = (-b + sqrt(discriminant_Root)) / (2 * a)
            let root2_Root = (-b - sqrt(discriminant_Root)) / (2 * a)
            return (root1_Root, root2_Root,discriminant_Root)
        }
    }
    
    // Solve Quadratic Equation Functions
    func solveQuadraticEquation() -> String{
        guard let root1_Equation = Double(self.root1_Equation),
              let root2_Equation = Double(self.root2_Equation)
                
        else {
            let equation = "isi dulu"
            return (equation)
        }
        
        let a = 1.0
        let b = -1 * (root1_Equation + root2_Equation)
        let c = root1_Equation * root2_Equation
        
        if b > 0.0 && c > 0.0{
            return "\(a)x^2 + \(b)x + \(c) = 0"
        }
        else if b < 0.0 && c > 0.0{
            let b = b * -1
            return "\(a)x^2 - \(b)x + \(c) = 0"
        }
        else if b > 0.0 && c < 0.0 {
            let c = c * -1
            return "\(a)x^2 + \(b)x - \(c) = 0"
        }
        else if b < 0.0 && c < 0.0 {
            let b = b * -1
            let c = c * -1
            return "\(a)x^2 - \(b)x - \(c) = 0"
        }
        else {
            let c = c * -1
            return "\(a)x^2 - \(c) = 0"
        }
    }
    
    var body: some View {
       
            
        NavigationStack{
                
                    // Picker
                    Picker(selection: $selectedTab, label: Text("Tabs")) {
                        ForEach(0..<tabs.count) { index in
                            Text(tabs[index])
                        }
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    VStack {
                    switch selectedTab {
                        // Root
                    case 0:
                        Form{
                            Section(header: Text("Find the Root")){
                                Text("Equation Form is Ax^2 + Bx + C")
                                VStack(alignment: .center) {
                                    TextField("Enter A", text: $a)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                    TextField("Enter B", text: $b)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                    TextField("Enter C", text: $c)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                    Spacer()
                                    if a.isEmpty || b.isEmpty || c.isEmpty{
                                        Button {
                                            calculateRoots()
                                            //let diskriminan = discriminant_Root
                                        } label: {
                                            Text("Find Roots")
                                                .frame(maxWidth: .infinity)
                                                .font(.title2)
                                        }
                                        .padding(10)
                                        .background(.yellow)
                                        .cornerRadius(10)
                                        .disabled(true)
                                    }else{
                                        Button {
                                            calculateRoots()
                                            //let diskriminan = discriminant_Root
                                        } label: {
                                            Text("Find Roots")
                                                .frame(maxWidth: .infinity)
                                                .font(.title2)
                                        }
                                        .padding(10)
                                        .background(.yellow)
                                        .foregroundColor(.primary)
                                        .cornerRadius(10)
                                    }
                                    
                                    
                                    
                                }

                            }
                            .listRowSeparator(.hidden)
                            .padding(5)
                            
                            
                            Section{
                                VStack{
                                    Text("Result")
                                        .font(.title)
                                    Divider()
                                    Spacer()
                                    HStack{
                                        if (discriminant_Root ==  nil) {
                                            Text("Please Input The Equation")
                                                .frame(maxWidth: .infinity)
                                        }
                                       else if (discriminant_Root ?? 0) < 0.0 {
                                            VStack{
                                                Spacer()
                                                HStack{
                                                    
                                                    Text(" There's No Real Root")
                                                        .font(.title3)
                                                    
                                                    
                                                }
                                                Spacer()
                                                Text("Discriminant : \(discriminant_Root ?? 0, specifier: "%.2f")")
                                            }
                                            
                                        }else{
                                            VStack{
                                                Spacer()
                                                HStack{
                                                    
                                                    Text(" X1 : \(root1_Root ?? 0, specifier: "%.2f") ")
                                                        .font(.title3)
                                                    Text(" X2 : \(root2_Root ?? 0, specifier: "%.2f")")
                                                        .font(.title3)
                                                }
                                                Spacer()
                                                Text("Discriminant : \(discriminant_Root ?? 0, specifier: "%.2f")")
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    Spacer()
                                    
                                }
                                .padding()
                                
                            }
                            
                        }
                        .scrollContentBackground(.hidden)
                        
                        // Equation
                    case 1:
                        Form{
                            Section(header: Text("Find The Equation")){
                                Text("Enter The Roots")
                                VStack(alignment: .center) {
                                    TextField("Enter X1", text: $root1_Equation)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                    TextField("Enter X2", text: $root2_Equation)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                    Spacer()
                                    if a.isEmpty || b.isEmpty || c.isEmpty{
                                        Button {
                                            result = solveQuadraticEquation()
                                        } label: {
                                            Text("Make an Equation")
                                                .frame(maxWidth: .infinity)
                                                .font(.title2)
                                            
                                        }
                                        .padding(10)
                                        .background(.yellow)
                                        .cornerRadius(10)
                                        
                                    }else{
                                        Button {
                                            result = solveQuadraticEquation()
                                        } label: {
                                            Text("Make an Equation")
                                                .frame(maxWidth: .infinity)
                                                .font(.title2)
                                            
                                        }
                                        .padding(10)
                                        .background(.yellow)
                                        .cornerRadius(10)
                                        .foregroundColor(.primary)
                                    }
                                    
                                  
                                    
                                    
                                }
                                
                            }
                            .listRowSeparator(.hidden)
                            .padding(5)
                            
                           
                            Section{
                                VStack{
                                    Text("Result")
                                        .font(.title)
                                    Divider()
                                    Spacer()
                                    HStack{
                                        
                                        if result == ""{
                                            Text("Please Input The Root!")
                                                .frame(maxWidth: .infinity)
                                                
                                                
                                        }else{
                                            Text(result)
                                                .frame(maxWidth: .infinity)
                                                .font(.title2)
                                        }
                                            
                                        
                                        Spacer()
                                        
                                    }
                                    
                                    
                                }
                               
                                .padding()
                            }
                            
                        }
                        .scrollContentBackground(.hidden)
                    default:
                        Text("Something went wrong.")
                    }
                    
                    
                }
                .navigationTitle("Root Equation Calc")
                .padding()
                .frame(maxWidth: .infinity,maxHeight:.infinity)
                .background(.ultraThinMaterial)
                .cornerRadius(25)
            }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        }
    
    

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
